package br.com.zup.beagle.ext

import br.com.zup.beagle.widget.core.UnitType
import org.junit.Test
import kotlin.test.assertEquals

class BeagleExtensions {

    @Test
    fun unitReal_should_return_a_UnitValue_with_100_double_REAL() {
        val actual = 100.unitReal()

        assertEquals(100.0, actual.value)
        assertEquals(UnitType.REAL, actual.type)
    }

    @Test
    fun unitPercent_should_return_a_UnitValue_with_100_double_PERCENT() {
        val actual = 100.unitPercent()

        assertEquals(100.0, actual.value)
        assertEquals(UnitType.PERCENT, actual.type)
    }

    @Test
    fun unitReal_should_return_a_UnitValue_with_100_REAL() {
        val actual = 100.unitReal()

        assertEquals(100.0, actual.value)
        assertEquals(UnitType.REAL, actual.type)
    }

    @Test
    fun unitPercent_should_return_a_UnitValue_with_100_PERCENT() {
        val actual = 100.unitPercent()

        assertEquals(100.0, actual.value)
        assertEquals(UnitType.PERCENT, actual.type)
    }
}