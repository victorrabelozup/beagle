/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.utils

import android.view.View
import android.widget.TextView
import br.com.zup.beagle.core.AccessibilityComponent
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.slot
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

class AccessibilitySetupTest {

    @MockK
    private lateinit var view: TextView
    @MockK
    private lateinit var component: AccessibilityComponent

    private val viewImportantForAccessibilitySlot = slot<Int>()
    private val viewContentDescriptionSlot = slot<String>()

    @InjectMockKs
    private lateinit var accessibilitySetup: AccessibilitySetup

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        every {
            view.importantForAccessibility = capture(viewImportantForAccessibilitySlot)
        } just Runs

        every {
            view.contentDescription = capture(viewContentDescriptionSlot)
        } just Runs
    }

    @Test
    fun applyAccessibility_when_component_is_accessible() {
        val result = View.IMPORTANT_FOR_ACCESSIBILITY_YES
        every { component.accessibility?.accessible } returns true
        every { component.accessibility?.accessibilityLabel } returns null

        accessibilitySetup.applyAccessibility(view, component)

        assertEquals(result, viewImportantForAccessibilitySlot.captured)
    }

    @Test
    fun applyAccessibility_when_component_is_not_accessible() {
        val result = View.IMPORTANT_FOR_ACCESSIBILITY_NO
        every { component.accessibility?.accessible } returns false
        every { component.accessibility?.accessibilityLabel } returns null

        accessibilitySetup.applyAccessibility(view, component)

        assertEquals(result, viewImportantForAccessibilitySlot.captured)
    }

    @Test
    fun applyAccessibility_when_has_accessibilityLabel() {
        val result = "Test with AccessibilityLabel"
        every { component.accessibility?.accessibilityLabel } returns "Test with AccessibilityLabel"
        every { component.accessibility?.accessible } returns true

        accessibilitySetup.applyAccessibility(view, component)

        assertEquals(result, viewContentDescriptionSlot.captured)
    }
}