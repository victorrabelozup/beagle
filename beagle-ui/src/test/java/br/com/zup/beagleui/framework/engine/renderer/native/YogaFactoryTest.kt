package br.com.zup.beagleui.framework.engine.renderer.native

/*
class YogaFactoryTest {

    private lateinit var yogaFactory: YogaFactory

    @Before
    fun setUp() {
        yogaFactory = YogaFactory()
    }

    @Test
    fun makeYogaNode_with_empty_parameter_should_return_a_valid_instance() {
        val yogaNode = yogaFactory.makeYogaNode()

        assertNotNull(yogaNode)
    }

    @Test
    fun makeYogaNode_with_flex_parameter_should_return_a_valid_instance() {
        // Given
        val flex = Flex(
            flexWrap = FlexWrap.WRAP,
            alignContent = Alignment.FLEX_START,
            alignItems = Alignment.FLEX_START,
            alignSelf = Alignment.FLEX_START,
            justifyContent = JustifyContent.FLEX_START,
            direction = Direction.INHERIT
        )

        // When
        val yogaNode = yogaFactory.makeYogaNode(flex)

        // Then
        assertEquals(YogaWrap.WRAP, yogaNode.wrap)
        assertEquals(YogaAlign.FLEX_START, yogaNode.alignContent)
        assertEquals(YogaAlign.FLEX_START, yogaNode.alignItems)
        assertEquals(YogaAlign.FLEX_START, yogaNode.alignSelf)
        assertEquals(YogaJustify.FLEX_START, yogaNode.justifyContent)
        assertEquals(YogaDirection.INHERIT, yogaNode.layoutDirection)
    }

    @Test
    fun makeYogaLayout_should_return_a_valid_instance_when_given_a_context() {
        // Given
        val context = mockk<Context>()

        // When
        val yogaLayout = yogaFactory.makeYogaLayout(context)

        // Then
        assertNotNull(yogaLayout)
    }

    @Test
    fun makeYogaLayout_should_return_a_valid_instance_when_given_a_context_and_a_flex() {
        // Given
        val context = mockk<Context>()
        val flex = mockk<Flex>()

        // When
        val yogaLayout = yogaFactory.makeYogaLayout(context, flex)

        // Then
        assertNotNull(yogaLayout)
    }
}*/
