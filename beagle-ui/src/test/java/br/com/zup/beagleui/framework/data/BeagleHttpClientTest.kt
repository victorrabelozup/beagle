package br.com.zup.beagleui.framework.data

import br.com.zup.beagleui.framework.data.deserializer.BeagleDeserializationException
import br.com.zup.beagleui.framework.data.deserializer.BeagleUiDeserialization
import br.com.zup.beagleui.framework.data.deserializer.makeContainerJson
import br.com.zup.beagleui.framework.exception.BeagleException
import br.com.zup.beagleui.framework.networking.RequestCall
import br.com.zup.beagleui.framework.networking.ResponseData
import br.com.zup.beagleui.framework.networking.HttpClient
import br.com.zup.beagleui.framework.testutil.RandomData
import br.com.zup.beagleui.framework.widget.core.Widget
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.slot
import io.mockk.verify
import kotlinx.coroutines.runBlocking
import org.junit.Before
import org.junit.Test
import java.lang.RuntimeException
import kotlin.test.assertEquals
import kotlin.test.assertFails

private val URL = RandomData.httpUrl()
private val WIDGET_DESERIALIZATION_ERROR = "Widget deserialization error for url"
class BeagleHttpClientTest {

    private val JSON_SUCCESS = makeContainerJson()
    private val JSON_ERROR = ""

    private val onSuccessSlot = slot<(responseData: ResponseData) -> Unit>()
    private val onErrorSlot = slot<(throwable: Throwable) -> Unit>()
    @MockK
    private lateinit var deserialization: BeagleUiDeserialization

    @MockK
    private lateinit var requestDispatching: HttpClient

    @InjectMockKs
    private lateinit var beagleHttpClient: BeagleHttpClient

    @MockK
    private lateinit var widget: Widget

    @MockK
    private lateinit var requestCall: RequestCall

    @MockK
    private lateinit var responseData: ResponseData

    @Before
    fun setup() {
        MockKAnnotations.init(this)

        mockListenerExecution {onSuccessSlot.captured(responseData)}
        every { deserialization.deserializeWidget(any()) } returns widget
        every { responseData.data } returns JSON_SUCCESS.toByteArray()
    }

    private fun mockListenerExecution(executionLambda: () -> Unit) {
        every {
            requestDispatching.execute(
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
    fun test_fetch_widget_should_return_widget_successfully() = runBlocking {
        val widgetResult = beagleHttpClient.fetchWidget(URL)

        verify(exactly = 1) { deserialization.deserializeWidget(any()) }
        assertEquals(widget, widgetResult)
    }

    @Test
    fun test_fetch_widget_should_return_error() = runBlocking {
        val message = "Error"
        val expectedException = BeagleException(message)
        mockListenerExecution {onErrorSlot.captured(expectedException)}
        val exceptionResponse = assertFails(message) {
            beagleHttpClient.fetchWidget(JSON_ERROR)
        }

        assertEquals(expectedException.message, exceptionResponse.message)
    }

    @Test
    fun test_fetch_widget_should_return_execute_error() = runBlocking {
        val message = "Any Error"
        val expectedException = BeagleDeserializationException(message)

        every { deserialization.deserializeWidget(any()) } throws expectedException

        val exceptionResponse = assertFails(message) {
            beagleHttpClient.fetchWidget(JSON_ERROR)
        }

        assertEquals(WIDGET_DESERIALIZATION_ERROR, exceptionResponse.message)
    }

    @Test
    fun test_fetch_widget_should_return_deserialization_error() = runBlocking {
        val message = "Error"
        val expectedException = IllegalArgumentException(message)

        every {
            requestDispatching.execute(
                any(),
                onSuccess = capture(onSuccessSlot),
                onError = capture(onErrorSlot)
            )
        } throws expectedException

        val exceptionResponse = assertFails(message) {
            beagleHttpClient.fetchWidget(JSON_ERROR)
        }

        assertEquals(expectedException.message, exceptionResponse.message)
    }

    @Test
    fun test_fetch_widget_should_return_empty_data_error() = runBlocking {
        val message = "The requested widget return were empty response"
        val expectedException = BeagleException(message)

        every { responseData.data } returns JSON_ERROR.toByteArray()

        val exceptionResponse = assertFails(message) {
            beagleHttpClient.fetchWidget(JSON_ERROR)
        }

        assertEquals(expectedException.message, exceptionResponse.message)
    }
}