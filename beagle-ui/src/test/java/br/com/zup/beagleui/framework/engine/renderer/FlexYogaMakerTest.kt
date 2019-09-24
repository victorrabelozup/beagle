package br.com.zup.beagleui.framework.engine.renderer

import br.com.zup.beagleui.framework.widget.core.Alignment
import br.com.zup.beagleui.framework.widget.core.FlexWrap
import br.com.zup.beagleui.framework.widget.core.ItemDirection
import br.com.zup.beagleui.framework.widget.core.JustifyContent
import com.facebook.yoga.YogaAlign
import com.facebook.yoga.YogaDirection
import com.facebook.yoga.YogaJustify
import com.facebook.yoga.YogaWrap
import org.junit.Test

import org.junit.Assert.*

class FlexYogaMakerTest {

    @Test
    fun makeYogaWrap_should_return_YogaWrap_NO_WRAP_when_FlexWrap_NO_WRAP() {
        // Given
        val flexWrap = FlexWrap.NO_WRAP

        // When
        val actual = makeYogaWrap(flexWrap)

        // Then
        assertEquals(YogaWrap.NO_WRAP, actual)
    }

    @Test
    fun makeYogaWrap_should_return_YogaWrap_WRAP_when_FlexWrap_WRAP() {
        // Given
        val flexWrap = FlexWrap.WRAP

        // When
        val actual = makeYogaWrap(flexWrap)

        // Then
        assertEquals(YogaWrap.WRAP, actual)
    }

    @Test
    fun makeYogaWrap_should_return_YogaWrap_WRAP_REVERSE_when_FlexWrap_WRAP_REVERSE() {
        // Given
        val flexWrap = FlexWrap.WRAP_REVERSE

        // When
        val actual = makeYogaWrap(flexWrap)

        // Then
        assertEquals(YogaWrap.WRAP_REVERSE, actual)
    }

    @Test
    fun makeYogaAlign_should_return_YogaAlign_CENTER_when_Alignment_CENTER() {
        // Given
        val alignment = Alignment.CENTER

        // When
        val actual = makeYogaAlign(alignment)

        // Then
        assertEquals(YogaAlign.CENTER, actual)
    }

    @Test
    fun makeYogaAlign_should_return_YogaAlign_FLEX_START_when_Alignment_FLEX_START() {
        // Given
        val alignment = Alignment.FLEX_START

        // When
        val actual = makeYogaAlign(alignment)

        // Then
        assertEquals(YogaAlign.FLEX_START, actual)
    }

    @Test
    fun makeYogaAlign_should_return_YogaAlign_FLEX_END_when_Alignment_FLEX_END() {
        // Given
        val alignment = Alignment.FLEX_END

        // When
        val actual = makeYogaAlign(alignment)

        // Then
        assertEquals(YogaAlign.FLEX_END, actual)
    }

    @Test
    fun makeYogaAlign_should_return_YogaAlign_SPACE_BETWEEN_when_Alignment_SPACE_BETWEEN() {
        // Given
        val alignment = Alignment.SPACE_BETWEEN

        // When
        val actual = makeYogaAlign(alignment)

        // Then
        assertEquals(YogaAlign.SPACE_BETWEEN, actual)
    }

    @Test
    fun makeYogaAlign_should_return_YogaAlign_SPACE_AROUND_when_Alignment_SPACE_AROUND() {
        // Given
        val alignment = Alignment.SPACE_AROUND

        // When
        val actual = makeYogaAlign(alignment)

        // Then
        assertEquals(YogaAlign.SPACE_AROUND, actual)
    }

    @Test
    fun makeYogaAlign_should_return_YogaAlign_BASELINE_when_Alignment_BASELINE() {
        // Given
        val alignment = Alignment.BASELINE

        // When
        val actual = makeYogaAlign(alignment)

        // Then
        assertEquals(YogaAlign.BASELINE, actual)
    }

    @Test
    fun makeYogaAlign_should_return_YogaAlign_AUTO_when_Alignment_AUTO() {
        // Given
        val alignment = Alignment.AUTO

        // When
        val actual = makeYogaAlign(alignment)

        // Then
        assertEquals(YogaAlign.AUTO, actual)
    }

    @Test
    fun makeYogaAlign_should_return_YogaAlign_STRETCH_when_Alignment_STRETCH() {
        // Given
        val alignment = Alignment.STRETCH

        // When
        val actual = makeYogaAlign(alignment)

        // Then
        assertEquals(YogaAlign.STRETCH, actual)
    }

    @Test
    fun makeYogaJustify_should_return_YogaJustify_FLEX_START_when_JustifyContent_FLEX_START() {
        // Given
        val alignment = JustifyContent.FLEX_START

        // When
        val actual = makeYogaJustify(alignment)

        // Then
        assertEquals(YogaJustify.FLEX_START, actual)
    }

    @Test
    fun makeYogaJustify_should_return_YogaJustify_CENTER_when_JustifyContent_CENTER() {
        // Given
        val alignment = JustifyContent.CENTER

        // When
        val actual = makeYogaJustify(alignment)

        // Then
        assertEquals(YogaJustify.CENTER, actual)
    }

    @Test
    fun makeYogaJustify_should_return_YogaJustify_FLEX_END_when_JustifyContent_FLEX_END() {
        // Given
        val alignment = JustifyContent.FLEX_END

        // When
        val actual = makeYogaJustify(alignment)

        // Then
        assertEquals(YogaJustify.FLEX_END, actual)
    }

    @Test
    fun makeYogaJustify_should_return_YogaJustify_SPACE_BETWEEN_when_JustifyContent_SPACE_BETWEEN() {
        // Given
        val alignment = JustifyContent.SPACE_BETWEEN

        // When
        val actual = makeYogaJustify(alignment)

        // Then
        assertEquals(YogaJustify.SPACE_BETWEEN, actual)
    }

    @Test
    fun makeYogaJustify_should_return_YogaJustify_SPACE_AROUND_when_JustifyContent_SPACE_AROUND() {
        // Given
        val alignment = JustifyContent.SPACE_AROUND

        // When
        val actual = makeYogaJustify(alignment)

        // Then
        assertEquals(YogaJustify.SPACE_AROUND, actual)
    }

    @Test
    fun makeYogaJustify_should_return_YogaJustify_SPACE_EVENLY_when_JustifyContent_SPACE_EVENLY() {
        // Given
        val alignment = JustifyContent.SPACE_EVENLY

        // When
        val actual = makeYogaJustify(alignment)

        // Then
        assertEquals(YogaJustify.SPACE_EVENLY, actual)
    }

    @Test
    fun makeYogaDirection_should_return_YogaDirection_INHERIT_when_ItemDirection_INHERIT() {
        // Given
        val alignment = ItemDirection.INHERIT

        // When
        val actual = makeYogaDirection(alignment)

        // Then
        assertEquals(YogaDirection.INHERIT, actual)
    }

    @Test
    fun makeYogaDirection_should_return_YogaDirection_LTR_when_ItemDirection_LTR() {
        // Given
        val alignment = ItemDirection.LTR

        // When
        val actual = makeYogaDirection(alignment)

        // Then
        assertEquals(YogaDirection.LTR, actual)
    }

    @Test
    fun makeYogaDirection_should_return_YogaDirection_RTL_when_ItemDirection_RTL() {
        // Given
        val alignment = ItemDirection.RTL

        // When
        val actual = makeYogaDirection(alignment)

        // Then
        assertEquals(YogaDirection.RTL, actual)
    }
}