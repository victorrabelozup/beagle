package br.com.zup.beagle.form

import br.com.zup.beagle.data.deserializer.BeagleDeserializer
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.networking.HttpClient
import br.com.zup.beagle.networking.HttpMethod
import br.com.zup.beagle.networking.RequestData
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.testutil.RandomData
import br.com.zup.beagle.widget.form.Form
import br.com.zup.beagle.widget.form.FormMethodType
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.slot
import io.mockk.unmockkObject
import io.mockk.verify
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

private val FORMS_VALUE = mapOf<String, String>()

class FormSubmitterTest {

    @MockK
    private lateinit var httpClient: HttpClient
    @MockK
    private lateinit var beagleDeserializer: BeagleDeserializer

    private val requestDataSlot = slot<RequestData>()

    @InjectMockKs
    private lateinit var formSubmitter: FormSubmitter

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
        mockkObject(BeagleEnvironment)
        every { BeagleEnvironment.baseUrl } returns RandomData.httpUrl()

        every { httpClient.execute(capture(requestDataSlot), any(), any()) } returns mockk()
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleEnvironment)
    }

    @Test
    fun submitForm_should_create_requestData_correctly() {
        // Given
        val action = RandomData.string()
        val form = Form(
            action = action,
            method = FormMethodType.POST,
            child = mockk()
        )
        val inputName = RandomData.string()
        val inputValue = RandomData.string()
        val formsValue = mapOf(inputName to inputValue)

        // When
        formSubmitter.submitForm(form, formsValue) {}

        // Then
        verify(exactly = once()) { httpClient.execute(any(), any(), any()) }

        val requestData = requestDataSlot.captured
        assertEquals(HttpMethod.POST, requestData.method)
        assertEquals("""{"$inputName":"$inputValue"}""", requestData.body)
        assertEquals(action, requestData.path)
    }

    @Test
    fun submitForm_should_create_requestData_with_PUT_httpMethod() {
        // Given
        val form = Form(
            action = RandomData.string(),
            method = FormMethodType.PUT,
            child = mockk()
        )

        // When
        formSubmitter.submitForm(form, FORMS_VALUE) {}

        // Then
        assertEquals(HttpMethod.PUT, requestDataSlot.captured.method)
    }

    @Test
    fun submitForm_should_create_requestData_with_DELETE_httpMethod() {
        // Given
        val form = Form(
            action = RandomData.string(),
            method = FormMethodType.DELETE,
            child = mockk()
        )

        // When
        formSubmitter.submitForm(form, FORMS_VALUE) {}

        // Then
        assertEquals(HttpMethod.DELETE, requestDataSlot.captured.method)
    }

    @Test
    fun submitForm_should_create_requestData_with_GET_httpMethod() {
        // Given
        val form = Form(
            action = RandomData.string(),
            method = FormMethodType.GET,
            child = mockk()
        )

        // When
        formSubmitter.submitForm(form, FORMS_VALUE) {}

        // Then
        assertEquals(HttpMethod.GET, requestDataSlot.captured.method)
    }

    @Test
    fun submitForm_should_create_requestData_with_POST_httpMethod() {
        // Given
        val form = Form(
            action = RandomData.string(),
            method = FormMethodType.POST,
            child = mockk()
        )

        // When
        formSubmitter.submitForm(form, FORMS_VALUE) {}

        // Then
        assertEquals(HttpMethod.POST, requestDataSlot.captured.method)
    }

    @Test
    fun submitForm_should_set_form_action_as_url_on_requestData() {
        // Given
        val action = RandomData.string()
        val form = Form(
            action = action,
            method = FormMethodType.POST,
            child = mockk()
        )

        // When
        formSubmitter.submitForm(form, FORMS_VALUE) {}

        // Then
        assertEquals(action, requestDataSlot.captured.path)
    }

    @Test
    fun submitForm_should_set_querystring_as_url_on_requestData_when_method_is_GET() {
        // Given
        val formsValue = mapOf(
            RandomData.string(3) to RandomData.string(3),
            RandomData.string(3) to RandomData.string(3)
        )
        val action = RandomData.string()
        val form = Form(
            action = action,
            method = FormMethodType.GET,
            child = mockk()
        )

        // When
        formSubmitter.submitForm(form, formsValue) {}

        // Then
        val formElements = formsValue.entries
        val element0 = formElements.elementAt(0)
        val element1 = formElements.elementAt(1)
        val expected = "$action?${element0.key}=${element0.value}&${element1.key}=${element1.value}"
        assertEquals(expected, requestDataSlot.captured.path)
    }

    @Test
    fun submitForm_should_set_querystring_as_url_on_requestData_when_method_is_DELETE() {
        // Given
        val formsValue = mapOf(
            RandomData.string(3) to RandomData.string(3),
            RandomData.string(3) to RandomData.string(3)
        )
        val action = RandomData.string()
        val form = Form(
            action = action,
            method = FormMethodType.GET,
            child = mockk()
        )

        // When
        formSubmitter.submitForm(form, formsValue) {}

        // Then
        val formElements = formsValue.entries
        val element0 = formElements.elementAt(0)
        val element1 = formElements.elementAt(1)
        val expected = "$action?${element0.key}=${element0.value}&${element1.key}=${element1.value}"
        assertEquals(expected, requestDataSlot.captured.path)
    }

    @Test
    fun submitForm_should_put_requestData_body_when_method_is_POST() {
        // Given
        val formsValue = mapOf(
            RandomData.string(3) to RandomData.string(3),
            RandomData.string(3) to RandomData.string(3)
        )
        val action = RandomData.string()
        val form = Form(
            action = action,
            method = FormMethodType.POST,
            child = mockk()
        )

        // When
        formSubmitter.submitForm(form, formsValue) {}

        // Then
        val formElements = formsValue.entries
        val element0 = formElements.elementAt(0)
        val element1 = formElements.elementAt(1)
        val expected =
            """{"${element0.key}":"${element0.value}", "${element1.key}":"${element1.value}"}"""
        assertEquals(expected, requestDataSlot.captured.body)
    }

    @Test
    fun submitForm_should_put_requestData_body_when_method_is_PUT() {
        // Given
        val formsValue = mapOf(
            RandomData.string(3) to RandomData.string(3),
            RandomData.string(3) to RandomData.string(3)
        )
        val action = RandomData.string()
        val form = Form(
            action = action,
            method = FormMethodType.POST,
            child = mockk()
        )

        // When
        formSubmitter.submitForm(form, formsValue) {}

        // Then
        val formElements = formsValue.entries
        val element0 = formElements.elementAt(0)
        val element1 = formElements.elementAt(1)
        val expected =
            """{"${element0.key}":"${element0.value}", "${element1.key}":"${element1.value}"}"""
        assertEquals(expected, requestDataSlot.captured.body)
    }
}