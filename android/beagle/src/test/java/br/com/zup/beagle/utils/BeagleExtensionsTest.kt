package br.com.zup.beagle.utils

import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.view.BeagleActivity
import io.mockk.MockKAnnotations
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.verify
import org.junit.Before
import org.junit.Test
import kotlin.test.assertNotNull

class BeagleExtensionsTest {

    @RelaxedMockK
    private lateinit var beagleActivity: BeagleActivity

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
    }

    @Test
    fun configureSupportActionBarShouldSetSupportActionBar() {
        beagleActivity.configureSupportActionBar()
        verify(exactly = once()) { beagleActivity.setSupportActionBar(any()) }
        assertNotNull(beagleActivity.supportActionBar)
    }
}