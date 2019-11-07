package br.com.zup.beagleui.framework.data

import br.com.zup.beagleui.framework.data.deserializer.BeagleUiDeserialization
import br.com.zup.beagleui.framework.data.deserializer.makeContainerJson
import br.com.zup.beagleui.framework.exception.BeagleDataException
import br.com.zup.beagleui.framework.networking.RequestCall
import br.com.zup.beagleui.framework.networking.ResponseData
import br.com.zup.beagleui.framework.networking.HttpClient
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
import kotlin.test.assertEquals
import kotlin.test.assertFails

const val URL = "http://www.mocky.io/v2/5d855b4b320000b90607b244"

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
        val expectedException = BeagleDataException(message)
        mockListenerExecution {onErrorSlot.captured(expectedException)}
        val exceptionResponse = assertFails(message) {
            beagleHttpClient.fetchWidget(JSON_ERROR)
        }

        assertEquals(expectedException.message, exceptionResponse.message)
    }
}