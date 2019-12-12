package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.children
import br.com.zup.beagleui.framework.action.ActionExecutor
import br.com.zup.beagleui.framework.action.FormValidationActionHandler
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.form.FormResult
import br.com.zup.beagleui.framework.form.FormSubmitter
import br.com.zup.beagleui.framework.form.InputValue
import br.com.zup.beagleui.framework.form.ValidationErrorListener
import br.com.zup.beagleui.framework.form.ValidatorHandler
import br.com.zup.beagleui.framework.logger.BeagleLogger
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.utils.hideKeyboard
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.form.Form
import br.com.zup.beagleui.framework.widget.form.FormInput
import br.com.zup.beagleui.framework.widget.form.FormSubmit

internal class FormViewRenderer(
    private val widget: Form,
    private val validatorHandler: ValidatorHandler? = BeagleEnvironment.validatorHandler,
    private val formValidationActionHandler: FormValidationActionHandler = FormValidationActionHandler(),
    private val formSubmitter: FormSubmitter = FormSubmitter(),
    private val actionExecutor: ActionExecutor = ActionExecutor(
        formValidationActionHandler = formValidationActionHandler
    ),
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    private val formInputViews = mutableListOf<View>()
    private var formSubmitView: View? = null

    override fun build(rootView: RootView): View {
        val view = viewRendererFactory.make(widget.child).build(rootView)

        if (view is ViewGroup) {
            fetchFormViews(view)
        }

        return view
    }

    private fun fetchFormViews(viewGroup: ViewGroup) {
        viewGroup.children.forEach { childView ->
            if (childView.tag != null) {
                if (childView.tag is FormInput) {
                    formInputViews.add(childView)
                } else if (childView.tag is FormSubmit && formSubmitView == null) {
                    formSubmitView = childView
                    addClickToFormSubmit(childView)
                }
            } else if (childView is ViewGroup) {
                fetchFormViews(childView)
            }
        }
    }

    private fun addClickToFormSubmit(formSubmitView: View) {
        formSubmitView.setOnClickListener {
            formValidationActionHandler.formInputViews = formInputViews
            handleFormSubmit(formSubmitView.context)
        }
    }

    private fun handleFormSubmit(context: Context) {
        val formsValue = mutableMapOf<String, String>()

        formInputViews.filterIsInstance<InputValue>().forEach { formInputView ->
            val formInput = (formInputView as View).tag as FormInput

            if (formInput.required == true) {
                validateFormFields(formInputView, formInput, formInputView, formsValue)
            } else {
                formsValue[formInput.name] = formInputView.getValue().toString()
            }
        }

        if (formsValue.size == formInputViews.size) {
            formInputViews.first().hideKeyboard()
            formSubmitter.submitForm(widget, formsValue) {
                (context as AppCompatActivity).runOnUiThread {
                    handleFormResult(context, it)
                }
            }
        }
    }

    private fun validateFormFields(
        formInputView: View,
        formInput: FormInput,
        inputValue: InputValue,
        formsValue: MutableMap<String, String>
    ) {
        val validator = formInput.validator
        if (validator != null) {
            validatorHandler?.getValidator(validator)?.let {
                val formValue = inputValue.getValue()

                when {
                    it.isValid(formValue) ->
                        formsValue[formInput.name] = inputValue.getValue().toString()
                    formInputView is ValidationErrorListener ->
                        formInputView.onValidationError(formInput.errorMessage)
                    else -> BeagleLogger.warning("FormInput with name ${formInput.name} is not valid" +
                            " and does not implement a ValidationErrorListener")
                }
            }
        }
    }

    private fun handleFormResult(context: Context, formResult: FormResult) {
        when (formResult) {
            is FormResult.Success -> actionExecutor.doAction(context, formResult.action)
            is FormResult.Error -> showError(context)
        }
    }

    private fun showError(context: Context) {
        viewFactory.makeAlertDialogBuilder(context)
            .setTitle("Error!")
            .setMessage("Something went wrong!")
            .setPositiveButton("OK") { dialog, _ ->
                dialog.dismiss()
            }
            .show()
    }
}
