package br.com.zup.beagle

import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.setup.BeagleSdk
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.unmockkObject
import org.junit.After
import org.junit.Before

abstract class BaseTest {

    protected val beagleSdk = mockk<BeagleSdk>(relaxed = true)

    @Before
    open fun setUp() {
        MockKAnnotations.init(this)

        mockkObject(BeagleEnvironment)
        every { BeagleEnvironment.beagleSdk } returns beagleSdk
    }

    @After
    open fun tearDown() {
        unmockkObject(BeagleEnvironment)
    }
}
