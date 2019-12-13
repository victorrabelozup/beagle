package br.com.zup.beagle.networking

import org.junit.Before

import org.junit.Assert.*
import org.junit.Test
import br.com.zup.beagle.testutil.RandomData

private val url = RandomData.httpUrl()

class RequestDataTest {

    private lateinit var requestData: RequestData

    @Before
    fun setUp() {
        requestData = RequestData(url)
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