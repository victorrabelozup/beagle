package br.com.zup.beagleui.framework.networking

import io.mockk.MockKAnnotations
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import org.junit.Before
import org.junit.Test
import kotlin.test.assertTrue

class URLRequestDispatchingFactoryTest {

    @MockK
    private lateinit var urlFactory: URLFactory

    @InjectMockKs
    private lateinit var urlRequestDispatchingFactory: URLRequestDispatchingFactory

    @Before
    fun setup() {
        MockKAnnotations.init(this)
    }

    @Test
    fun test() {
        val response = urlRequestDispatchingFactory.make()
        assertTrue { response is URLRequestDispatchingDefault }
    }
}