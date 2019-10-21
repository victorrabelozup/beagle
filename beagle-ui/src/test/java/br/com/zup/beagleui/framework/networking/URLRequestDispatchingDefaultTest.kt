package br.com.zup.beagleui.framework.networking

import io.mockk.*
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import junit.framework.Assert.assertTrue
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import java.io.InputStream
import java.net.HttpURLConnection
import java.net.URL
import kotlin.test.assertEquals

private val REQUEST_DATA = RequestData(url = "http://www.mocky.io/v2/5d855b4b320000b90607b244")
private val REQUEST_DATA_METHOD_NOT_SUPPORTED =
    RequestData(url = "http://www.mocky.io/v2/5d855b4b320000b90607b244", method = HttpMethod.PATCH)
private val HEADERS = mapOf(
    Pair("Authorization", "Bearer iusdohyHOjdosaijda=="),
    Pair("x-application-key", "dummy")
)
private val REQUEST_DATA_WITH_HEADERS =
    RequestData(url = "http://www.mocky.io/v2/5d855b4b320000b90607b244", headers = HEADERS)
private val BYTE_ARRAY_DATA = byteArrayOf()

class URLRequestDispatchingDefaultTest {

    @MockK
    private lateinit var beagleHttpClient: URLFactory

    @MockK
    private lateinit var url: URL

    @MockK
    private lateinit var httpURLConnection: HttpURLConnection

    @MockK
    private lateinit var inputStream: InputStream

    @InjectMockKs
    private lateinit var urlRequestDispatchingDefault: URLRequestDispatchingDefault

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkStatic("kotlin.io.ByteStreamsKt")

        every { beagleHttpClient.make(any()) } returns url
        every { url.openConnection() } returns httpURLConnection
        every { httpURLConnection.setRequestProperty(any(), any()) } just Runs
        every { httpURLConnection.inputStream } returns inputStream
        every { inputStream.readBytes() } returns BYTE_ARRAY_DATA
        every { httpURLConnection.disconnect() } just Runs
    }

    @Test
    fun execute_should_be_executed_successfully() {
        urlRequestDispatchingDefault.execute(REQUEST_DATA, onSuccess = {
            assertEquals(BYTE_ARRAY_DATA, it.data)
        }, onError = {
            Assert.fail("Test failed, should execute successfully")
        })

        verify(exactly = 1) { httpURLConnection.disconnect() }
    }

    @Test
    fun execute_should_be_executed_successfully_with_headers() {
        urlRequestDispatchingDefault.execute(REQUEST_DATA_WITH_HEADERS, onSuccess = {
        }, onError = {
            Assert.fail("Test failed, should execute successfully")
        })

        HEADERS.forEach {
            verify(exactly = 1) { httpURLConnection.setRequestProperty(it.key, it.value) }
        }

    }

    @Test
    fun execute_should_be_executed_with_error() {
        val runtimeException = RuntimeException("Error")
        every { httpURLConnection.inputStream } throws runtimeException


        urlRequestDispatchingDefault.execute(REQUEST_DATA, onSuccess = {
            Assert.fail("Test failed, should execute with error")

        }, onError = {
            assertEquals(runtimeException, it)
        })
    }

    @Test
    fun execute_should_be_executed_with_error_method_not_supported() {

        urlRequestDispatchingDefault.execute(REQUEST_DATA_METHOD_NOT_SUPPORTED, onSuccess = {
            Assert.fail("Test failed, should execute with error")
        }, onError = {
            assertTrue(it is IllegalArgumentException)
        })
    }

}