package br.com.zup.beagleui.framework.engine.renderer.layout

import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import br.com.zup.beagleui.framework.action.ActionExecutor
import br.com.zup.beagleui.framework.action.FormValidationActionHandler
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.form.FormResult
import br.com.zup.beagleui.framework.form.FormSubmitter
import br.com.zup.beagleui.framework.form.Validator
import br.com.zup.beagleui.framework.form.ValidatorHandler
import br.com.zup.beagleui.framework.logger.BeagleLogger
import br.com.zup.beagleui.framework.mockdata.FormInputView
import br.com.zup.beagleui.framework.mockdata.FormInputViewWithoutValidation
import br.com.zup.beagleui.framework.testutil.RandomData
import br.com.zup.beagleui.framework.testutil.getPrivateField
import br.com.zup.beagleui.framework.utils.hideKeyboard
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.form.Form
import br.com.zup.beagleui.framework.widget.form.FormInput
import br.com.zup.beagleui.framework.widget.form.FormSubmit
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.mockkStatic
import io.mockk.slot
import io.mockk.unmockkObject
import io.mockk.unmockkStatic
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

private const val FORM_INPUT_VIEWS_FIELD_NAME = "formInputViews"
private const val FORM_SUBMIT_VIEW_FIELD_NAME = "formSubmitView"
private val INPUT_VALUE = RandomData.string()

class FormViewRendererTest {

    @MockK
    private lateinit var form: Form
    @MockK(relaxed = true)
    private lateinit var formInput: FormInput
    @MockK
    private lateinit var formSubmit: FormSubmit
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var validatorHandler: ValidatorHandler
    @MockK
    private lateinit var validator: Validator
    @MockK
    private lateinit var formValidationActionHandler: FormValidationActionHandler
    @MockK(relaxed = true)
    private lateinit var actionExecutor: ActionExecutor
    @MockK
    private lateinit var formSubmitter: FormSubmitter
    @MockK
    private lateinit var viewRenderer: ViewRenderer
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var appCompatActivity: AppCompatActivity
    @MockK
    private lateinit var inputMethodManager: InputMethodManager
    @MockK(relaxed = true)
    private lateinit var formInputView: FormInputView
    @MockK(relaxed = true)
    private lateinit var formInputViewWithoutValidation: FormInputViewWithoutValidation
    @MockK
    private lateinit var formSubmitView: View
    @MockK
    private lateinit var viewGroup: ViewGroup

    private val onClickListenerSlot = slot<View.OnClickListener>()
    private val formResultCallbackSlot = slot<(formResult: FormResult) -> Unit>()

    private lateinit var formViewRenderer: FormViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        formViewRenderer = FormViewRenderer(
            form,
            validatorHandler,
            formValidationActionHandler,
            formSubmitter,
            actionExecutor,
            viewRendererFactory,
            viewFactory
        )

        mockkStatic("br.com.zup.beagleui.framework.utils.ViewExtensionsKt")
        mockkObject(BeagleLogger)

        every { viewRendererFactory.make(form) } returns viewRenderer
        every { viewRenderer.build(appCompatActivity) } returns viewGroup
        every { form.child } returns form
        every { formInput.required } returns false
        every { formInputViewWithoutValidation.hideKeyboard() } just Runs
        every { formInputViewWithoutValidation.context } returns appCompatActivity
        every { formInputViewWithoutValidation.tag } returns formInput
        every { formInputView.hideKeyboard() } just Runs
        every { formInputView.getValue() } returns INPUT_VALUE
        every { formInputView.context } returns appCompatActivity
        every { formInputView.tag } returns formInput
        every { formSubmitView.tag } returns formSubmit
        every { formSubmitView.context } returns appCompatActivity
        every { formSubmitView.setOnClickListener(capture(onClickListenerSlot)) } just Runs
        every { viewGroup.childCount } returns 2
        every { viewGroup.getChildAt(0) } returns formInputView
        every { viewGroup.getChildAt(1) } returns formSubmitView
        every { formValidationActionHandler.formInputViews = any() } just Runs
        every { appCompatActivity.getSystemService(any()) } returns inputMethodManager
        every { formSubmitter.submitForm(any(), any(), capture(formResultCallbackSlot)) } just Runs
        every { validatorHandler.getValidator(any()) } returns validator
    }

    @After
    fun tearDown() {
        unmockkStatic("br.com.zup.beagleui.framework.utils.ViewExtensionsKt")
        unmockkObject(BeagleLogger)
    }

    @Test
    fun build_should_not_try_to_iterate_over_children_if_is_not_a_ViewGroup() {
        // Given
        every { viewGroup.childCount } returns 0
        every { viewRenderer.build(appCompatActivity) } returns formInputView

        // When
        val actual = formViewRenderer.build(appCompatActivity)

        // Then
        assertEquals(formInputView, actual)
        verify(exactly = 0) { viewGroup.childCount }
    }

    @Test
    fun build_should_try_to_iterate_over_all_viewGroups() {
        // Given
        val childViewGroup = mockk<ViewGroup>()
        every { childViewGroup.childCount } returns 0
        every { viewGroup.childCount } returns 1
        every { viewGroup.getChildAt(any()) } returns childViewGroup

        // When
        formViewRenderer.build(appCompatActivity)

        // Then
        verify { childViewGroup.childCount }
    }

    @Test
    fun build_should_group_formInput_views() {
        formViewRenderer.build(appCompatActivity)

        val views = formViewRenderer.getPrivateField<List<View>>(FORM_INPUT_VIEWS_FIELD_NAME)
        assertEquals(1, views.size)
        assertEquals(formInputView, views[0])
    }

    @Test
    fun build_should_find_formSubmitView() {
        formViewRenderer.build(appCompatActivity)

        val actual = formViewRenderer.getPrivateField<View>(FORM_SUBMIT_VIEW_FIELD_NAME)
        assertEquals(formSubmitView, actual)
        verify(exactly = 1) { formSubmitView.setOnClickListener(any()) }
    }

    @Test
    fun onClick_of_formSubmit_should_set_formInputViews_on_formValidationActionHandler() {
        // Given When
        executeFormSubmitOnClickListener()

        // Then
        val views = formViewRenderer.getPrivateField<List<View>>(FORM_INPUT_VIEWS_FIELD_NAME)
        verify(exactly = 1) { formValidationActionHandler.formInputViews = views }
    }

    @Test
    fun onClick_of_formSubmit_should_set_submit_form_when_inputValue_is_not_required() {
        // Given When
        executeFormSubmitOnClickListener()

        // Then
        verify(exactly = 1) { formInputView.hideKeyboard() }
        verify(exactly = 1) { formSubmitter.submitForm(any(), any(), any()) }
    }

    @Test
    fun onClick_of_formSubmit_should_validate_formField_that_is_required_and_is_valid() {
        // Given
        every { formInput.required } returns true
        every { validator.isValid(any()) } returns true

        // When
        executeFormSubmitOnClickListener()

        // Then
        verify(exactly = 1) { validator.isValid(INPUT_VALUE) }
        verify(exactly = 1) { formSubmitter.submitForm(any(), any(), any()) }
    }

    @Test
    fun onClick_of_formSubmit_should_validate_formField_that_is_required_and_that_not_is_valid() {
        // Given
        every { formInput.required } returns true
        every { validator.isValid(any()) } returns false

        // When
        executeFormSubmitOnClickListener()

        // Then
        verify(exactly = 1) { formInputView.onValidationError(any()) }
        verify(exactly = 0) { formSubmitter.submitForm(any(), any(), any()) }
    }

    @Test
    fun onClick_of_formSubmit_should_validate_formField_that_does_implement_validation() {
        // Given
        every { formInput.required } returns true
        every { validator.isValid(any()) } returns false
        every { viewGroup.getChildAt(0) } returns formInputViewWithoutValidation
        every { BeagleLogger.warning(any()) } just Runs

        // When
        executeFormSubmitOnClickListener()

        // Then
        verify(exactly = 1) { BeagleLogger.warning("FormInput with name ${formInput.name} is not valid and does not implement a ValidationErrorListener") }
        verify(exactly = 0) { formSubmitter.submitForm(any(), any(), any()) }
    }

    @Test
    fun onClick_of_formSubmit_should_handleFormSubmit_and_call_actionExecutor() {
        // Given
        val formResult = FormResult.Success(mockk())

        // When
        executeFormSubmitOnClickListener()
        formResultCallbackSlot.captured(formResult)

        // Then
        verify(exactly = 1) { actionExecutor.doAction(appCompatActivity, formResult.action) }
    }

    @Test
    fun onClick_of_formSubmit_should_handleFormSubmit_and_call_showError() {
        // Given
        val formResult = FormResult.Error(mockk())
        val alertDialogBuilder = mockk<AlertDialog.Builder>()
        every { alertDialogBuilder.setTitle(any<String>()) } returns alertDialogBuilder
        every { alertDialogBuilder.setMessage(any<String>()) } returns alertDialogBuilder
        every { alertDialogBuilder.setPositiveButton(any<String>(), any()) } returns alertDialogBuilder
        every { alertDialogBuilder.show() } returns mockk()
        every { viewFactory.makeAlertDialogBuilder(appCompatActivity) } returns alertDialogBuilder


        // When
        executeFormSubmitOnClickListener()
        formResultCallbackSlot.captured(formResult)

        // Then
        verify(exactly = 1) { alertDialogBuilder.setTitle("Error!") }
        verify(exactly = 1) { alertDialogBuilder.setMessage("Something went wrong!") }
        verify(exactly = 1) { alertDialogBuilder.show() }
    }

    private fun executeFormSubmitOnClickListener() {
        formViewRenderer.build(appCompatActivity)
        onClickListenerSlot.captured.onClick(formSubmitView)
    }
}