package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.view.View
import android.view.ViewGroup
import androidx.core.view.children
import br.com.zup.beagle.action.ActionExecutor
import br.com.zup.beagle.action.FormValidationActionHandler
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.form.FormResult
import br.com.zup.beagle.form.FormSubmitter
import br.com.zup.beagle.form.FormValidatorController
import br.com.zup.beagle.form.ValidatorHandler
import br.com.zup.beagle.logger.BeagleMessageLogs
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.utils.hideKeyboard
import br.com.zup.beagle.view.BeagleActivity
import br.com.zup.beagle.view.ServerDrivenState
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.form.Form
import br.com.zup.beagle.widget.form.FormInput
import br.com.zup.beagle.widget.form.FormSubmit

internal class FormViewRenderer(
    override val component: Form,
    private val validatorHandler: ValidatorHandler? = BeagleEnvironment.beagleSdk.validatorHandler,
    private val formValidationActionHandler: FormValidationActionHandler = FormValidationActionHandler(),
    private val formSubmitter: FormSubmitter = FormSubmitter(),
    private val formValidatorController: FormValidatorController = FormValidatorController(),
    private val actionExecutor: ActionExecutor = ActionExecutor(
        formValidationActionHandler = formValidationActionHandler
    ),
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer<Form>(viewRendererFactory, viewFactory) {

    private val formInputs = mutableListOf<FormInput>()
    private var formSubmitView: View? = null

    override fun buildView(rootView: RootView): View {
        val view = viewRendererFactory.make(component.child).build(rootView)

        if (view is ViewGroup) {
            fetchFormViews(view)
        }

        if (formInputs.size == 0) {
            BeagleMessageLogs.logFormInputsNotFound(component.path)
        }

        if (formSubmitView == null) {
            BeagleMessageLogs.logFormSubmitNotFound(component.path)
        }

        return view
    }

    private fun fetchFormViews(viewGroup: ViewGroup) {
        viewGroup.children.forEach { childView ->
            if (childView.tag != null) {
                val tag = childView.tag
                if (tag is FormInput) {
                    formInputs.add(tag)
                    formValidatorController.configFormInputList(tag)
                } else if (childView.tag is FormSubmit && formSubmitView == null) {
                    formSubmitView = childView
                    addClickToFormSubmit(childView)
                    formValidatorController.formSubmitView = childView
                }
            } else if (childView is ViewGroup) {
                fetchFormViews(childView)
            }
        }

        formValidatorController.configFormSubmit()
    }

    private fun addClickToFormSubmit(formSubmitView: View) {
        formSubmitView.setOnClickListener {
            formValidationActionHandler.formInputs = formInputs
            handleFormSubmit(formSubmitView.context)
        }
    }

    private fun handleFormSubmit(context: Context) {
        val formsValue = mutableMapOf<String, String>()

        formInputs.forEach { formInput ->
            if (formInput.required == true) {
                validateFormInput(formInput, formsValue)
            } else {
                formsValue[formInput.name] = formInput.child.getValue().toString()
            }
        }

        if (formsValue.size == formInputs.size) {
            formSubmitView?.hideKeyboard()
            formSubmitter.submitForm(component, formsValue) {
                (context as BeagleActivity).runOnUiThread {
                    handleFormResult(context, it)
                }
            }
        }
    }

    private fun validateFormInput(
        formInput: FormInput,
        formsValue: MutableMap<String, String>
    ) {
        val validator = formInput.validator
        if (validator != null) {
            validatorHandler?.getValidator(validator)?.let {
                val inputWidget = formInput.child
                val inputValue = inputWidget.getValue()

                if (it.isValid(inputValue, inputWidget)) {
                    formsValue[formInput.name] = inputValue.toString()
                } else {
                    inputWidget.onErrorMessage(formInput.errorMessage ?: "")
                }
            } ?: run {
                BeagleMessageLogs.logFormValidatorNotFound(validator)
            }
        }
    }

    private fun handleFormResult(beagleActivity: BeagleActivity, formResult: FormResult) {
        when (formResult) {
            is FormResult.Success -> actionExecutor.doAction(beagleActivity, formResult.action)
            is FormResult.Error -> beagleActivity.onServerDrivenContainerStateChanged(
                ServerDrivenState.Error(formResult.throwable)
            )
        }
    }
}

data class FormInputValidator(
    val formInput: FormInput,
    var isValid: Boolean
)