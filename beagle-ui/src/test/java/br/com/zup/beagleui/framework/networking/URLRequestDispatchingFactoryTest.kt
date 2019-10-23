package br.com.zup.beagleui.framework.networking

import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.mockkObject
import io.mockk.unmockkObject
import org.junit.After
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue

class URLRequestDispatchingFactoryTest {

    @MockK
    private lateinit var urlFactory: URLFactory

    @InjectMockKs
    private lateinit var urlRequestDispatchingFactory: URLRequestDispatchingFactory

    @MockK
    private lateinit var networkingDispatcher: URLRequestDispatching

    @Before
    fun setup() {
        MockKAnnotations.init(this)
        mockkObject(BeagleEnvironment)
        every { BeagleEnvironment.networkingDispatcher } returns null
    }

    @After
    fun after() {
        unmockkObject(BeagleEnvironment)
        BeagleEnvironment.theme = null
        BeagleEnvironment.networkingDispatcher = null
    }

    @Test
    fun test_make_should_return_default_dispatcher() {
        val response = urlRequestDispatchingFactory.make()
        assertTrue { response is URLRequestDispatchingDefault }
    }

    @Test
    fun test_make_should_return_custom_dispatcher() {
        every { BeagleEnvironment.networkingDispatcher } returns networkingDispatcher

        val response = urlRequestDispatchingFactory.make()
        assertEquals(networkingDispatcher, response)
    }
}