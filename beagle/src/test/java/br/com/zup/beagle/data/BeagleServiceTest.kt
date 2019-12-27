package br.com.zup.beagle.data

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.data.cache.BeagleWidgetCacheHelper
import br.com.zup.beagle.data.deserializer.BeagleDeserializer
import br.com.zup.beagle.data.deserializer.makeScreenWidgetJson
import br.com.zup.beagle.exception.BeagleException
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.logger.BeagleMessageLogs
import br.com.zup.beagle.networking.HttpClient
import br.com.zup.beagle.networking.RequestCall
import br.com.zup.beagle.networking.ResponseData
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.testutil.RandomData
import br.com.zup.beagle.widget.core.Widget
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockkObject
import io.mockk.slot
import io.mockk.unmockkObject
import io.mockk.verify
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runBlockingTest
import org.junit.After
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals
import kotlin.test.assertFails
import kotlin.test.assertTrue


private val URL = RandomData.httpUrl()
private val JSON_SUCCESS = makeScreenWidgetJson()
private const val JSON_ERROR = ""

@ExperimentalCoroutinesApi
class BeagleServiceTest {

    private val onSuccessSlot = slot<(responseData: ResponseData) -> Unit>()
    private val onErrorSlot = slot<(throwable: Throwable) -> Unit>()

    @MockK
    private lateinit var deserializer: BeagleDeserializer
    @MockK
    private lateinit var httpClient: HttpClient
    @MockK
    private lateinit var widget: Widget
    @MockK
    private lateinit var action: Action
    @MockK
    private lateinit var requestCall: RequestCall
    @MockK
    private lateinit var responseData: ResponseData

    @InjectMockKs
    private lateinit var beagleService: BeagleService

    @Before
    fun setup() {
        MockKAnnotations.init(this, relaxUnitFun = true)

        mockkObject(BeagleMessageLogs)
        mockkObject(BeagleEnvironment)
        mockkObject(BeagleWidgetCacheHelper)

        mockListenerExecution { onSuccessSlot.captured(responseData) }
        every { BeagleEnvironment.baseUrl } returns RandomData.httpUrl()
        every { BeagleMessageLogs.logHttpRequestData(any()) } just Runs
        every { BeagleMessageLogs.logHttpResponseData(any()) } just Runs
        every { BeagleMessageLogs.logUnknownHttpError(any()) } just Runs
        every { deserializer.deserializeWidget(any()) } returns widget
        every { BeagleWidgetCacheHelper.getWidgetFromCache(any()) } returns null
        every { BeagleWidgetCacheHelper.cacheWidget(any(), any()) } returns widget
        every { deserializer.deserializeAction(any()) } returns action
        every { responseData.data } returns JSON_SUCCESS.toByteArray()
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleWidgetCacheHelper)
        unmockkObject(BeagleMessageLogs)
        unmockkObject(BeagleEnvironment)
    }

    private fun mockListenerExecution(executionLambda: () -> Unit) {
        every {
            httpClient.execute(
                any(),
                onSuccess = capture(onSuccessSlot),
                onError = capture(onErrorSlot)
            )
        } answers {
            executionLambda()
            requestCall
        }
    }

    @Test
    fun fetchWidget_should_deserialize_a_widget_response() = runBlockingTest {
        val widgetResult = beagleService.fetchWidget(URL)

        verify(exactly = once()) { deserializer.deserializeWidget(JSON_SUCCESS) }
        assertEquals(widget, widgetResult)
    }

    @Test
    fun fetchWidget_should_return_a_exception_when_some_http_call_fails() = runBlockingTest {
        // Given
        val message = RandomData.string()
        val expectedException = BeagleException(message)
        mockListenerExecution { onErrorSlot.captured(expectedException) }

        // When
        val exceptionResponse = assertFails(message) {
            beagleService.fetchWidget(JSON_ERROR)
        }

        // Then
        assertEquals(expectedException.message, exceptionResponse.message)
    }

    @Test
    fun fetchWidget_should_return_a_exception_when_http_throws_a_exception() = runBlockingTest {
        // Given
        val exception = RuntimeException()
        every { httpClient.execute(any(), any(), any()) } throws exception

        // When
        val exceptionResponse = assertFails {
            beagleService.fetchWidget(JSON_ERROR)
        }

        // Then
        assertTrue(exceptionResponse is BeagleException)
    }

    @Test
    fun fetchWidget_should_return_a_exception_moshi_deserialization_fails() = runBlockingTest {
        // Given
        val exception = BeagleException(RandomData.string())
        every { deserializer.deserializeWidget(any()) } throws exception

        // When
        val exceptionResponse =
            assertFails("Widget deserializer error with respective json: $JSON_ERROR") {
                beagleService.fetchWidget(JSON_ERROR)
            }

        // Then
        assertTrue(exceptionResponse is BeagleException)
    }

    @Test
    fun fetchAction_should_deserialize_a_action_response() = runBlockingTest {
        val actionResult = beagleService.fetchAction(URL)

        verify(exactly = once()) { deserializer.deserializeAction(JSON_SUCCESS) }
        assertEquals(action, actionResult)
    }

    @Test
    fun fetchAction_should_return_a_exception_moshi_deserialization_fails() = runBlockingTest {
        // Given
        val exception = BeagleException(RandomData.string())
        every { deserializer.deserializeAction(any()) } throws exception

        // When
        val exceptionResponse =
            assertFails("Action deserializer error with respective json: $JSON_ERROR") {
                beagleService.fetchAction(JSON_ERROR)
            }

        // Then
        assertTrue(exceptionResponse is BeagleException)
    }
}