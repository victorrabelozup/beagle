package br.com.zup.beagleui.framework.view

import org.junit.Before
import org.junit.Test
import kotlin.test.assertTrue

private const val SCREEN_URL = "http://teste.com/test"

class BeagleUIFragmentTest {

    @Before
    fun setUp() {
    }

    @Test
    fun newInstance_should_set_screenUrl_on_bundle() {
        val fragment = BeagleUIFragment.newInstance(SCREEN_URL)

    }

    @Test
    fun onCreateView() {
    }
}
