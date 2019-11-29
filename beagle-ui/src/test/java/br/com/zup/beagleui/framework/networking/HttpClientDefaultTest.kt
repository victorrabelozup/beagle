package br.com.zup.beagleui.framework.networking

import br.com.zup.beagleui.framework.extensions.once
import br.com.zup.beagleui.framework.testutil.CoroutineTestRule
import br.com.zup.beagleui.framework.testutil.RandomData
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.verify
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runBlockingTest
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import java.io.IOException
import java.io.InputStream
import java.io.OutputStream
import java.net.HttpURLConnection
import java.net.URL
import kotlin.test.assertEquals
import kotlin.test.assertFails
import kotlin.test.assertTrue
import kotlin.test.fail

private val REQUEST_DATA = RequestData(url = RandomData.httpUrl())
private val BYTE_ARRAY_DATA = byteArrayOf()
private const val STATUS_CODE = 200

@ExperimentalCoroutinesApi
class HttpClientDefaultTest {

    @get:Rule val scope = CoroutineTestRule()

    @MockK
    private lateinit var url: URL
    @MockK
    private lateinit var urlFactory: URLFactory
    @MockK
    private lateinit var httpURLConnection: HttpURLConnection

    @MockK
    private lateinit var inputStream: InputStream

    private lateinit var urlRequestDispatchingDefault: HttpClientDefault

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        urlRequestDispatchingDefault = HttpClientDefault(urlFactory)

        mockkStatic("kotlin.io.ByteStreamsKt")

        every { urlFactory.make(any()) } returns url
        every { url.openConnection() } returns httpURLConnection
        every { httpURLConnection.requestMethod = any() } just Runs
        every { httpURLConnection.setRequestProperty(any(), any()) } just Runs
        every { httpURLConnection.disconnect() } just Runs
        every { httpURLConnection.headerFields } returns mapOf()
        every { httpURLConnection.responseCode } returns STATUS_CODE
        every { httpURLConnection.inputStream } returns inputStream
        every { inputStream.readBytes() } returns BYTE_ARRAY_DATA
    }

    @Test
    fun execute_should_be_executed_successfully() = runBlockingTest {
        // Given
        val headerName = RandomData.string()
        val headerValue = RandomData.string()
        val headers = mapOf(headerName to listOf(headerValue))
        every { httpURLConnection.headerFields } returns headers
        
        lateinit var resultData: ResponseData
        urlRequestDispatchingDefault.execute(REQUEST_DATA, onSuccess = {
            resultData = it
        }, onError = {
            fail("Test failed, should execute successfully")
        })

        assertEquals(STATUS_CODE, resultData.statusCode)
        assertEquals(BYTE_ARRAY_DATA, resultData.data)
        assertEquals(headerName, resultData.headers.keys.elementAt(0))
        assertEquals(headerValue, resultData.headers[headerName])
    }

    @Test
    fun execute_should_disconnect_after_response() = runBlockingTest {
        urlRequestDispatchingDefault.execute(REQUEST_DATA, onSuccess = {}, onError = {})

        verify(exactly = once()) { httpURLConnection.disconnect() }
    }

    @Test
    fun execute_should_set_headers() = runBlockingTest {
        // Given
        val headers = mapOf(
            Pair(RandomData.string(), RandomData.string()),
            Pair(RandomData.string(), RandomData.string())
        )
        val requestData = RequestData(url = RandomData.httpUrl(), headers = headers)

        // When
        urlRequestDispatchingDefault.execute(requestData, onSuccess = {}, onError = {})

        // Then
        headers.forEach {
            verify(exactly = once()) { httpURLConnection.setRequestProperty(it.key, it.value) }
        }
    }

    @Test
    fun execute_should_set_requestBody() = runBlockingTest {
        // Given
        val data = RandomData.string()
        val outputStream = mockk<OutputStream>()
        val requestData = RequestData(url = RandomData.httpUrl(), body = data, method = HttpMethod.POST)
        every { httpURLConnection.outputStream } returns outputStream
        every { outputStream.write(any<ByteArray>()) } just Runs

        // When
        urlRequestDispatchingDefault.execute(requestData, onSuccess = {}, onError = {})

        // Then
        verify(exactly = once()) { outputStream.write(data.toByteArray()) }
        verify(exactly = once()) { httpURLConnection.setRequestProperty("Content-Length", data.length.toString()) }
    }

    @Test
    fun execute_should_throw_IllegalArgumentException_when_data_is_set_for_HttpMethod_GET() = runBlockingTest {
        // Given
        val method = HttpMethod.GET
        val requestData = RequestData(
            url = RandomData.httpUrl(),
            body = RandomData.string(),
            method = method
        )

        // When
        val exception = assertFails("$method does not support request body") {
            urlRequestDispatchingDefault.execute(requestData, onSuccess = {}, onError = {})
        }

        // Then
        assertTrue(exception is IllegalArgumentException)
    }

    @Test
    fun execute_should_throw_IllegalArgumentException_when_data_is_set_for_HttpMethod_DELETE() = runBlockingTest {
        // Given
        val method = HttpMethod.DELETE
        val requestData = RequestData(
            url = RandomData.httpUrl(),
            body = RandomData.string(),
            method = method
        )

        // When
        val exception = assertFails("$method does not support request body") {
            urlRequestDispatchingDefault.execute(requestData, onSuccess = {}, onError = {})
        }

        // Then
        assertTrue(exception is IllegalArgumentException)
    }

    @Test
    fun execute_should_throw_IllegalArgumentException_when_data_is_set_for_HttpMethod_HEAD() = runBlockingTest {
        // Given
        val method = HttpMethod.HEAD
        val requestData = RequestData(
            url = RandomData.httpUrl(),
            body = RandomData.string(),
            method = method
        )

        // When
        val exception = assertFails("$method does not support request body") {
            urlRequestDispatchingDefault.execute(requestData, onSuccess = {}, onError = {})
        }

        // Then
        assertTrue(exception is IllegalArgumentException)
    }

    @Test
    fun execute_should_throw_IllegalStateException_when_data_is_set_for_HttpMethod_DELETE() = runBlockingTest {
        // Given
        val method = HttpMethod.GET
        val requestData = RequestData(
            url = RandomData.httpUrl(),
            body = RandomData.string(),
            method = method
        )

        // When
        val exception = assertFails("$method does not support request body") {
            urlRequestDispatchingDefault.execute(requestData, onSuccess = {}, onError = {})
        }

        // Then
        assertTrue(exception is IllegalArgumentException)
    }

    @Test
    fun execute_should_set_HttpMethod_GET() = runBlockingTest {
        // Given
        val requestData = RequestData(url = RandomData.httpUrl(), method = HttpMethod.GET)

        // When
        urlRequestDispatchingDefault.execute(requestData, onSuccess = {}, onError = {})

        // Then
        verify(exactly = 0) { httpURLConnection.setRequestProperty("X-HTTP-Method-Override", "GET") }
        verify(exactly = once()) { httpURLConnection.requestMethod = "GET" }
    }

    @Test
    fun execute_should_set_HttpMethod_POST() = runBlockingTest {
        // Given
        val requestData = RequestData(url = RandomData.httpUrl(), method = HttpMethod.POST)

        // When
        urlRequestDispatchingDefault.execute(requestData, onSuccess = {}, onError = {})

        // Then
        verify(exactly = 0) { httpURLConnection.setRequestProperty("X-HTTP-Method-Override", "POST") }
        verify(exactly = once()) { httpURLConnection.requestMethod = "POST" }
    }

    @Test
    fun execute_should_set_HttpMethod_PUT() = runBlockingTest {
        // Given
        val requestData = RequestData(url = RandomData.httpUrl(), method = HttpMethod.PUT)

        // When
        urlRequestDispatchingDefault.execute(requestData, onSuccess = {}, onError = {})

        // Then
        verify(exactly = 0) { httpURLConnection.setRequestProperty("X-HTTP-Method-Override", "PUT") }
        verify(exactly = once()) { httpURLConnection.requestMethod = "PUT" }
    }

    @Test
    fun execute_should_set_HttpMethod_DELETE() = runBlockingTest {
        // Given
        val requestData = RequestData(url = RandomData.httpUrl(), method = HttpMethod.DELETE)

        // When
        urlRequestDispatchingDefault.execute(requestData, onSuccess = {}, onError = {})

        // Then
        verify(exactly = 0) { httpURLConnection.setRequestProperty("X-HTTP-Method-Override", "DELETE") }
        verify(exactly = once()) { httpURLConnection.requestMethod = "DELETE" }
    }

    @Test
    fun execute_should_set_HttpMethod_HEAD() = runBlockingTest {
        // Given
        val requestData = RequestData(url = RandomData.httpUrl(), method = HttpMethod.HEAD)

        // When
        urlRequestDispatchingDefault.execute(requestData, onSuccess = {}, onError = {})

        // Then
        verify(exactly = once()) { httpURLConnection.setRequestProperty("X-HTTP-Method-Override", "HEAD") }
        verify(exactly = once()) { httpURLConnection.requestMethod = "POST" }
    }

    @Test
    fun execute_should_set_HttpMethod_PATCH() = runBlockingTest {
        // Given
        val requestData = RequestData(url = RandomData.httpUrl(), method = HttpMethod.PATCH)

        // When
        urlRequestDispatchingDefault.execute(requestData, onSuccess = {}, onError = {})

        // Then
        verify(exactly = once()) { httpURLConnection.setRequestProperty("X-HTTP-Method-Override", "PATCH") }
        verify(exactly = once()) { httpURLConnection.requestMethod = "POST" }
    }

    @Test
    fun execute_should_be_executed_with_error() {
        // Given
        val runtimeException = RuntimeException()
        every { httpURLConnection.inputStream } throws runtimeException

        // When
        var errorResult: Throwable? = null
        urlRequestDispatchingDefault.execute(REQUEST_DATA, onSuccess = {
            fail("Test failed, should execute with error")
        }, onError = {
            errorResult = it
        })

        // Then
        assertTrue { errorResult is IOException }
    }
}