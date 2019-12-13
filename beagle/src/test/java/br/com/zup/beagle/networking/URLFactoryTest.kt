package br.com.zup.beagle.networking

import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

const val URL = "http://www.mocky.io/v2/5d855b4b320000b90607b244"
class URLFactoryTest {
    private lateinit var urlFactory: URLFactory

    @Before
    fun setup() {
        urlFactory = URLFactory()
    }

    @Test
    fun test_make_should_return_url_successfully() {
        val url = urlFactory.make(URL)
        assertEquals(URL, url.toURI().toString())
    }
}