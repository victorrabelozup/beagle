/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.utils

import org.junit.Test

import org.junit.Assert.*

private interface A<T>
private class B : A<String>
private class C

class GenericExtensionsKtTest {

    @Test
    fun implementsGenericTypeOf_should_return_true_when_generic_type_match() {
        // Given
        val clazz = B()

        // When
        val actual = clazz.implementsGenericTypeOf(A::class.java, String::class.java)

        // Then
        assertTrue(actual)
    }

    @Test
    fun implementsGenericTypeOf_should_return_false_when_generic_type_does_not_match() {
        // Given
        val clazz = B()

        // When
        val actual = clazz.implementsGenericTypeOf(A::class.java, Int::class.java)

        // Then
        assertFalse(actual)
    }

    @Test
    fun implementsGenericTypeOf_should_return_false_when_class_does_not_implements_expected_interface() {
        // Given
        val clazz = C()

        // When
        val actual = clazz.implementsGenericTypeOf(A::class.java, String::class.java)

        // Then
        assertFalse(actual)
    }
}