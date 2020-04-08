/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.action

import android.content.Context
import android.view.View
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.logger.BeagleLogger
import br.com.zup.beagle.testutil.RandomData
import br.com.zup.beagle.widget.form.FormInput
import br.com.zup.beagle.widget.form.InputWidget
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.unmockkObject
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

class FormValidationActionHandlerTest {

    @MockK
    private lateinit var context: Context

    private lateinit var formValidationActionHandler: FormValidationActionHandler

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        formValidationActionHandler = FormValidationActionHandler()

        mockkObject(BeagleLogger)
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleLogger)
    }

    @Test
    fun handle_should_iterate_over_errors_and_call_ValidationErrorListener_of_view_with_name() {
        // Given
        val view = mockk<View>(relaxed = true)
        val formInput = mockk<FormInput>(relaxed = true)
        val inputWidget = mockk<InputWidget>(relaxed = true)
        val inputName = RandomData.string()
        val validationMessage = RandomData.string()
        val formValidation = FormValidation(
            errors = listOf(
                FieldError(inputName, validationMessage)
            )
        )
        every { view.tag } returns formInput
        every { formInput.name } returns inputName
        every { formInput.child } returns inputWidget
        formValidationActionHandler.formInputs = listOf(formInput)

        // When
        formValidationActionHandler.handle(context, formValidation)

        // Then
        verify(exactly = once()) { inputWidget.onErrorMessage(validationMessage) }
    }

    @Test
    fun handle_should_iterate_over_errors_and_log_validationListener_not_found() {
        // Given
        val inputName = RandomData.string()
        val formValidation = FormValidation(
            errors = listOf(
                FieldError(inputName, RandomData.string())
            )
        )
        every { BeagleLogger.warning(any()) } just Runs

        // When
        formValidationActionHandler.handle(context, formValidation)

        // Then
        val logMessage = "Input name with name $inputName does not implement ValidationErrorListener"
        verify(exactly = once()) { BeagleLogger.warning(logMessage) }
    }
}