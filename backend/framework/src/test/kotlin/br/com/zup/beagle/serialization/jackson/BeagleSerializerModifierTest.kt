/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.ComposeComponent
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import com.fasterxml.jackson.databind.BeanDescription
import com.fasterxml.jackson.databind.JsonSerializer
import com.fasterxml.jackson.databind.ser.std.BeanSerializerBase
import io.mockk.every
import io.mockk.mockk
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import kotlin.reflect.KClass
import kotlin.test.assertTrue

internal class BeagleSerializerModifierTest {
    @Test
    fun modifySerializer_for_non_Beagle_type_should_return_the_input_serializer() =
        testModifySerializer(
            clazz = Any::class.java,
            expectedSerializerClass = BeanSerializerBase::class,
            compareSerializers = Assertions::assertSame
        )

    @Test
    fun modifySerializer_for_Action_should_return_BeagleTypeSerializer() =
        testModifySerializer(
            clazz = Action::class.java,
            expectedSerializerClass = BeagleTypeSerializer::class,
            compareSerializers = Assertions::assertNotSame
        )

    @Test
    fun modifySerializer_for_Action_subtype_should_return_BeagleTypeSerializer() =
        testModifySerializer(
            clazz = Navigate::class.java,
            expectedSerializerClass = BeagleTypeSerializer::class,
            compareSerializers = Assertions::assertNotSame
        )

    @Test
    fun modifySerializer_for_Screen_should_return_BeagleTypeSerializer() =
        testModifySerializer(
            clazz = Screen::class.java,
            expectedSerializerClass = BeagleTypeSerializer::class,
            compareSerializers = Assertions::assertNotSame
        )

    @Test
    fun modifySerializer_for_ServerDrivenComponent_should_return_BeagleTypeSerializer() =
        testModifySerializer(
            clazz = ServerDrivenComponent::class.java,
            expectedSerializerClass = BeagleTypeSerializer::class,
            compareSerializers = Assertions::assertNotSame
        )

    @Test
    fun modifySerializer_for_ServerDrivenComponent_subtype_should_return_BeagleTypeSerializer() =
        testModifySerializer(
            clazz = Widget::class.java,
            expectedSerializerClass = BeagleTypeSerializer::class,
            compareSerializers = Assertions::assertNotSame
        )

    @Test
    fun modifySerializer_for_ComposeComponent_should_return_BeagleBuilderSerializer() =
        testModifySerializer(
            clazz = ComposeComponent::class.java,
            expectedSerializerClass = BeagleBuilderSerializer::class,
            compareSerializers = Assertions::assertNotSame
        )

    @Test
    fun modifySerializer_for_ComposeComponent_subtype_should_return_BeagleBuilderSerializer() =
        testModifySerializer(
            clazz = MyComposeComponent::class.java,
            expectedSerializerClass = BeagleBuilderSerializer::class,
            compareSerializers = Assertions::assertNotSame
        )

    @Test
    fun modifySerializer_for_ScreenBuilder_should_return_BeagleBuilderSerializer() =
        testModifySerializer(
            clazz = ScreenBuilder::class.java,
            expectedSerializerClass = BeagleBuilderSerializer::class,
            compareSerializers = Assertions::assertNotSame
        )

    @Test
    fun modifySerializer_for_ScreenBuilder_subtype_should_return_BeagleBuilderSerializer() =
        testModifySerializer(
            clazz = MyScreenBuilder::class.java,
            expectedSerializerClass = BeagleBuilderSerializer::class,
            compareSerializers = Assertions::assertNotSame
        )

    private fun testModifySerializer(
        clazz: Class<*>,
        expectedSerializerClass: KClass<*>,
        compareSerializers: (BeanSerializerBase, JsonSerializer<*>) -> Unit
    ) {
        val description = mockk<BeanDescription>()
        val serializer = mockk<BeanSerializerBase>()

        every { description.beanClass } returns clazz

        val result = BeagleSerializerModifier.modifySerializer(mockk(), description, serializer)

        compareSerializers(serializer, result)
        assertTrue { expectedSerializerClass.isInstance(result) }
    }

    abstract class MyComposeComponent : ComposeComponent()

    abstract class MyScreenBuilder : ScreenBuilder
}