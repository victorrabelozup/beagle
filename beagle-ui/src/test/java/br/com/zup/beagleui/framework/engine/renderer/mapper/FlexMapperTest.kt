package br.com.zup.beagleui.framework.engine.renderer.mapper

import br.com.zup.beagleui.framework.utils.px
import br.com.zup.beagleui.framework.widget.core.Alignment
import br.com.zup.beagleui.framework.widget.core.Direction
import br.com.zup.beagleui.framework.widget.core.EdgeValue
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.FlexDirection
import br.com.zup.beagleui.framework.widget.core.FlexDisplay
import br.com.zup.beagleui.framework.widget.core.FlexWrap
import br.com.zup.beagleui.framework.widget.core.JustifyContent
import br.com.zup.beagleui.framework.widget.core.Size
import br.com.zup.beagleui.framework.widget.core.UnitType
import br.com.zup.beagleui.framework.widget.core.UnitValue
import com.facebook.yoga.YogaAlign
import com.facebook.yoga.YogaDirection
import com.facebook.yoga.YogaDisplay
import com.facebook.yoga.YogaEdge
import com.facebook.yoga.YogaFlexDirection
import com.facebook.yoga.YogaJustify
import com.facebook.yoga.YogaNode
import com.facebook.yoga.YogaWrap
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.clearStaticMockk
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockkStatic
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

private const val HUNDRED_UNIT_VALUE = 100.0
private const val ONE_UNIT_VALUE = 1.0

class FlexMapperTest {

    @MockK
    private lateinit var yogaNode: YogaNode

    private lateinit var flexMapper: FlexMapper

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        flexMapper = FlexMapper()

        mockkStatic(YogaNode::class)
        mockkStatic("br.com.zup.beagleui.framework.utils.NumberExtensionsKt")

        every { HUNDRED_UNIT_VALUE.px() } returns HUNDRED_UNIT_VALUE
        every { ONE_UNIT_VALUE.px() } returns ONE_UNIT_VALUE
        every { YogaNode.create() } returns yogaNode
        every { yogaNode.flexDirection = any() } just Runs
        every { yogaNode.setDirection(any()) } just Runs
        every { yogaNode.wrap = any() } just Runs
        every { yogaNode.justifyContent = any() } just Runs
        every { yogaNode.alignItems = any() } just Runs
        every { yogaNode.alignSelf = any() } just Runs
        every { yogaNode.alignContent = any() } just Runs
        every { yogaNode.flexGrow = any() } just Runs
        every { yogaNode.flexShrink = any() } just Runs
        every { yogaNode.display = any() } just Runs
        every { yogaNode.aspectRatio = any() } just Runs
        every { yogaNode.setWidth(any()) } just Runs
        every { yogaNode.setWidthPercent(any()) } just Runs
        every { yogaNode.setHeight(any()) } just Runs
        every { yogaNode.setHeightPercent(any()) } just Runs
        every { yogaNode.setMaxWidth(any()) } just Runs
        every { yogaNode.setMaxWidthPercent(any()) } just Runs
        every { yogaNode.setMaxHeight(any()) } just Runs
        every { yogaNode.setMaxHeightPercent(any()) } just Runs
        every { yogaNode.setMinWidth(any()) } just Runs
        every { yogaNode.setMinWidthPercent(any()) } just Runs
        every { yogaNode.setMinHeight(any()) } just Runs
        every { yogaNode.setMinHeightPercent(any()) } just Runs
        every { yogaNode.setFlexBasis(any()) } just Runs
        every { yogaNode.setFlexBasisPercent(any()) } just Runs
        every { yogaNode.setMargin(any(), any()) } just Runs
        every { yogaNode.setMarginPercent(any(), any()) } just Runs
        every { yogaNode.setPadding(any(), any()) } just Runs
        every { yogaNode.setPaddingPercent(any(), any()) } just Runs
        every { yogaNode.setPosition(any(), any()) } just Runs
        every { yogaNode.setPositionPercent(any(), any()) } just Runs
        every { yogaNode.setFlexBasisAuto() } just Runs
    }

    @After
    fun tearDown() {
        clearStaticMockk()
    }

    @Test
    fun makeYogaNode_should_set_flexDirection_as_COLUMN() {
        // Given
        val flex = Flex(
            flexDirection = FlexDirection.COLUMN
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.flexDirection = YogaFlexDirection.COLUMN }
    }

    @Test
    fun makeYogaNode_should_set_direction_as_INHERIT() {
        // Given
        val flex = Flex(
            direction = Direction.INHERIT
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setDirection(YogaDirection.INHERIT) }
    }

    @Test
    fun makeYogaNode_should_set_wrap_as_WRAP() {
        // Given
        val flex = Flex(
            flexWrap = FlexWrap.WRAP
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.wrap = YogaWrap.WRAP }
    }

    @Test
    fun makeYogaNode_should_set_justifyContent_as_SPACE_BETWEEN() {
        // Given
        val flex = Flex(
            justifyContent = JustifyContent.SPACE_BETWEEN
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.justifyContent = YogaJustify.SPACE_BETWEEN }
    }

    @Test
    fun makeYogaNode_should_set_alignItems_as_SPACE_BETWEEN() {
        // Given
        val flex = Flex(
            alignItems = Alignment.FLEX_START
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.alignItems = YogaAlign.FLEX_START }
    }

    @Test
    fun makeYogaNode_should_set_alignSelf_as_SPACE_BETWEEN() {
        // Given
        val flex = Flex(
            alignSelf = Alignment.FLEX_START
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.alignSelf = YogaAlign.FLEX_START }
    }

    @Test
    fun makeYogaNode_should_set_alignContent_as_SPACE_BETWEEN() {
        // Given
        val flex = Flex(
            alignContent = Alignment.FLEX_START
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.alignContent = YogaAlign.FLEX_START }
    }

    @Test
    fun makeYogaNode_should_set_flexGrow_as_SPACE_BETWEEN() {
        // Given
        val flex = Flex(
            grow = ONE_UNIT_VALUE
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.flexGrow = ONE_UNIT_VALUE.toFloat() }
    }

    @Test
    fun makeYogaNode_should_set_shrink_as_1() {
        // Given
        val flex = Flex(
            shrink = ONE_UNIT_VALUE
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.flexShrink = ONE_UNIT_VALUE.toFloat() }
    }

    @Test
    fun makeYogaNode_should_set_display_as_FLEX() {
        // Given
        val flex = Flex(
            display = FlexDisplay.FLEX
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.display = YogaDisplay.FLEX }
    }

    @Test
    fun makeYogaNode_should_set_display_as_NONE() {
        // Given
        val flex = Flex(
            display = FlexDisplay.NONE
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.display = YogaDisplay.NONE }
    }

    @Test
    fun makeYogaNode_should_set_width_as_100_0() {
        // Given
        val flex = Flex(
            size = Size(width = UnitValue(HUNDRED_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setWidth(HUNDRED_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_widthPercent_as_100_0() {
        // Given
        val flex = Flex(
            size = Size(width = UnitValue(HUNDRED_UNIT_VALUE, UnitType.PERCENT))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setWidthPercent(HUNDRED_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_height_as_100_0() {
        // Given
        val flex = Flex(
            size = Size(height = UnitValue(HUNDRED_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setHeight(HUNDRED_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_heightPercent_as_100_0() {
        // Given
        val flex = Flex(
            size = Size(height = UnitValue(HUNDRED_UNIT_VALUE, UnitType.PERCENT))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setHeightPercent(HUNDRED_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_maxWidth_as_100_0() {
        // Given
        val flex = Flex(
            size = Size(maxWidth = UnitValue(HUNDRED_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMaxWidth(HUNDRED_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_maxWidthPercent_as_100_0() {
        // Given
        val flex = Flex(
            size = Size(maxWidth = UnitValue(HUNDRED_UNIT_VALUE, UnitType.PERCENT))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMaxWidthPercent(HUNDRED_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_maxHeight_as_100_0() {
        // Given
        val flex = Flex(
            size = Size(maxHeight = UnitValue(HUNDRED_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMaxHeight(HUNDRED_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_maxHeightPercent_as_100_0() {
        // Given
        val flex = Flex(
            size = Size(maxHeight = UnitValue(HUNDRED_UNIT_VALUE, UnitType.PERCENT))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMaxHeightPercent(HUNDRED_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_minWidth_as_100_0() {
        // Given
        val flex = Flex(
            size = Size(minWidth = UnitValue(HUNDRED_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMinWidth(HUNDRED_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_minWidthPercent_as_100_0() {
        // Given
        val flex = Flex(
            size = Size(minWidth = UnitValue(HUNDRED_UNIT_VALUE, UnitType.PERCENT))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMinWidthPercent(HUNDRED_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_minHeight_as_100_0() {
        // Given
        val flex = Flex(
            size = Size(minHeight = UnitValue(HUNDRED_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMinHeight(HUNDRED_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_minHeightPercent_as_100_0() {
        // Given
        val flex = Flex(
            size = Size(minHeight = UnitValue(HUNDRED_UNIT_VALUE, UnitType.PERCENT))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMinHeightPercent(HUNDRED_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_basis_as_1() {
        // Given
        val flex = Flex(
            basis = UnitValue(ONE_UNIT_VALUE, UnitType.REAL)
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setFlexBasis(ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_basisPercent_as_1() {
        // Given
        val flex = Flex(
            basis = UnitValue(ONE_UNIT_VALUE, UnitType.PERCENT)
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setFlexBasisPercent(ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_basisAuto() {
        // Given
        val flex = Flex(
            basis = UnitValue(ONE_UNIT_VALUE, UnitType.AUTO)
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setFlexBasisAuto() }
    }

    @Test
    fun makeYogaNode_should_set_aspectRatio_as_1() {
        // Given
        val flex = Flex(
            size = Size(aspectRatio = ONE_UNIT_VALUE)
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.aspectRatio = ONE_UNIT_VALUE.toFloat() }
    }

    @Test
    fun makeYogaNode_should_set_margin_as_TOP_and_1() {
        // Given
        val flex = Flex(
            margin = EdgeValue(top = UnitValue(ONE_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMargin(YogaEdge.TOP, ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_margin_as_LEFT_and_1() {
        // Given
        val flex = Flex(
            margin = EdgeValue(left = UnitValue(ONE_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMargin(YogaEdge.LEFT, ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_margin_as_RIGHT_and_1() {
        // Given
        val flex = Flex(
            margin = EdgeValue(right = UnitValue(ONE_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMargin(YogaEdge.RIGHT, ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_margin_as_BOTTOM_and_1() {
        // Given
        val flex = Flex(
            margin = EdgeValue(bottom = UnitValue(ONE_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMargin(YogaEdge.BOTTOM, ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_margin_as_START_and_1() {
        // Given
        val flex = Flex(
            margin = EdgeValue(start = UnitValue(ONE_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMargin(YogaEdge.START, ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_margin_as_END_and_1() {
        // Given
        val flex = Flex(
            margin = EdgeValue(end = UnitValue(ONE_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMargin(YogaEdge.END, ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_margin_as_ALL_and_1() {
        // Given
        val flex = Flex(
            margin = EdgeValue(all = UnitValue(ONE_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMargin(YogaEdge.ALL, ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_margin_as_VERTICAL_and_1() {
        // Given
        val flex = Flex(
            margin = EdgeValue(vertical = UnitValue(ONE_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMargin(YogaEdge.VERTICAL, ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_margin_as_HORIZONTAL_and_1() {
        // Given
        val flex = Flex(
            margin = EdgeValue(horizontal = UnitValue(ONE_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMargin(YogaEdge.HORIZONTAL, ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_marginPercent_as_TOP_and_1() {
        // Given
        val flex = Flex(
            margin = EdgeValue(top = UnitValue(ONE_UNIT_VALUE, UnitType.PERCENT))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setMarginPercent(YogaEdge.TOP, ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_padding_as_TOP_and_1() {
        // Given
        val flex = Flex(
            padding = EdgeValue(top = UnitValue(ONE_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setPadding(YogaEdge.TOP, ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_paddingPercent_as_TOP_and_1() {
        // Given
        val flex = Flex(
            padding = EdgeValue(top = UnitValue(ONE_UNIT_VALUE, UnitType.PERCENT))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setPaddingPercent(YogaEdge.TOP, ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_position_as_TOP_and_1() {
        // Given
        val flex = Flex(
            position = EdgeValue(top = UnitValue(ONE_UNIT_VALUE, UnitType.REAL))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setPosition(YogaEdge.TOP, ONE_UNIT_VALUE.toFloat()) }
    }

    @Test
    fun makeYogaNode_should_set_positionPercent_as_TOP_and_1() {
        // Given
        val flex = Flex(
            position = EdgeValue(top = UnitValue(ONE_UNIT_VALUE, UnitType.PERCENT))
        )

        // When
        val yogaNode = flexMapper.makeYogaNode(flex)

        // Then
        verify(exactly = 1) { yogaNode.setPositionPercent(YogaEdge.TOP, ONE_UNIT_VALUE.toFloat()) }
    }
}