package br.com.zup.beagleui.framework.widget.core

import org.junit.Before

import org.junit.Assert.*
import org.junit.Test

class FlexTest {

    private lateinit var flex: Flex

    @Before
    fun setUp() {
        flex = Flex()
    }

    @Test
    fun flexDirection_should_return_FlexDirection_COLUMN() {
        val actual = flex.flexDirection

        assertEquals(FlexDirection.COLUMN, actual)
    }

    @Test
    fun direction_should_return_Direction_LTR() {
        val actual = flex.direction

        assertEquals(Direction.LTR, actual)
    }

    @Test
    fun flexWrap_should_return_FlexWrap_NO_WRAP() {
        val actual = flex.flexWrap

        assertEquals(FlexWrap.NO_WRAP, actual)
    }

    @Test
    fun justifyContent_should_return_JustifyContent_FLEX_START() {
        val actual = flex.justifyContent

        assertEquals(JustifyContent.FLEX_START, actual)
    }

    @Test
    fun alignItems_should_return_Alignment_STRETCH() {
        val actual = flex.alignItems

        assertEquals(Alignment.STRETCH, actual)
    }

    @Test
    fun alignSelf_should_return_Alignment_AUTO() {
        val actual = flex.alignSelf

        assertEquals(Alignment.AUTO, actual)
    }

    @Test
    fun alignContent_should_return_Alignment_FLEX_START() {
        val actual = flex.alignContent

        assertEquals(Alignment.FLEX_START, actual)
    }

    @Test
    fun positionType_should_return_Alignment_RELATIVE() {
        val actual = flex.positionType

        assertEquals(FlexPositionType.RELATIVE, actual)
    }

    @Test
    fun basis_should_return_UnitValue_zero_and_AUTO() {
        val actual = flex.basis

        assertEquals(0.0, actual.value, 0.0)
    }

    @Test
    fun flex_should_return_zero() {
        val actual = flex.flex

        assertEquals(0.0, actual, 0.0)
    }

    @Test
    fun grow_should_return_zero() {
        val actual = flex.grow

        assertEquals(0.0, actual, 0.0)
    }

    @Test
    fun shrink_should_return_1() {
        val actual = flex.shrink

        assertEquals(1.0, actual, 0.0)
    }

    @Test
    fun display_should_return_FlexDisplay_FLEX() {
        val actual = flex.display

        assertEquals(FlexDisplay.FLEX, actual)
    }

    @Test
    fun size_should_return_not_null_size() {
        val actual = flex.size

        assertNotNull(actual)
    }

    @Test
    fun margin_should_return_not_null_margin() {
        val actual = flex.margin

        assertNotNull(actual)
    }

    @Test
    fun padding_should_return_not_null_padding() {
        val actual = flex.padding

        assertNotNull(actual)
    }

    @Test
    fun position_should_return_not_null_position() {
        val actual = flex.position

        assertNotNull(actual)
    }
}