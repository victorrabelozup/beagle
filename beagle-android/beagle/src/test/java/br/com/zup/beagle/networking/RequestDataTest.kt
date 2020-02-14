package br.com.zup.beagle.networking

import br.com.zup.beagle.testutil.RandomData
import org.junit.Before

import org.junit.Test
import java.net.URI
import kotlin.test.assertEquals
import kotlin.test.assertNull
import kotlin.test.assertTrue

class RequestDataTest {

    private lateinit var requestData: RequestData

    @Before
    fun setUp() {
        requestData = RequestData(URI(RandomData.httpUrl()))
    }

    @Test
    fun requestData_should_have_method_GET_as_default() {
        assertEquals(HttpMethod.GET, requestData.method)
    }

    @Test
    fun requestData_should_have_empty_headers() {
        assertTrue(requestData.headers.isEmpty())
    }

    @Test
    fun requestData_should_have_data_null() {
        assertNull(requestData.body)
    }
}