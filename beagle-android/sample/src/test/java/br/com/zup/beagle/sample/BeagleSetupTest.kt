package br.com.zup.beagle.sample

import br.com.zup.beagle.setup.BeagleSdk
import org.junit.Test
import kotlin.test.assertNotNull
import kotlin.test.assertNull
import kotlin.test.assertTrue

class BeagleSetupTest {

    private val beagleSetup = BeagleSetup()

    @Test
    fun beagleSetup_should_be_instance_of_BeagleSdk() {
        assertTrue(beagleSetup is BeagleSdk)
    }

    @Test
    fun registeredWidgets_should_have_3_elements_in_list() {
        assertTrue(beagleSetup.registeredWidgets().isNotEmpty())
    }

    @Test
    fun customActionHandler_should_have_a_valid_instance() {
        assertNotNull(beagleSetup.customActionHandler)
    }

    @Test
    fun deepLinkHandler_should_have_a_valid_instance() {
        assertNotNull(beagleSetup.deepLinkHandler)
    }

    @Test
    fun httpClient_should_be_null() {
        assertNull(beagleSetup.httpClient)
    }

    @Test
    fun designSystem_should_have_a_valid_instance() {
        assertNotNull(beagleSetup.designSystem)
    }

    @Test
    fun validatorHandler_should_have_a_valid_instance() {
        assertNotNull(beagleSetup.validatorHandler)
    }

    @Test
    fun config_should_have_a_valid_instance() {
        assertNotNull(beagleSetup.config)
    }
}
