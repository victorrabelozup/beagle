/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.builder

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.ext.unitReal
import br.com.zup.beagle.sample.constants.BUTTON_STYLE_FORM
import br.com.zup.beagle.sample.constants.LIGHT_GREEN
import br.com.zup.beagle.sample.constants.SUBMIT_FORM_ENDPOINT
import br.com.zup.beagle.sample.widget.SampleTextField
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.form.Form
import br.com.zup.beagle.widget.form.FormInput
import br.com.zup.beagle.widget.form.FormMethodType
import br.com.zup.beagle.widget.form.FormRemoteAction
import br.com.zup.beagle.widget.form.FormSubmit
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.Button

object FormScreenBuilder : ScreenBuilder {
    private val flexHorizontalMargin = Flex(margin = EdgeValue(all = 10.unitReal()))

    override fun build() = Screen(
        navigationBar = NavigationBar(
            title = "Form",
            navigationBarItems = listOf(
                NavigationBarItem(
                    text = "",
                    image = "informationImage",
                    action = ShowNativeDialog(
                        title = "Form",
                        message = "A formSubmit component will define a submit handler in a form.",
                        buttonText = "OK"
                    )
                )
            )
        ),
        child = ScrollView(
            scrollDirection = ScrollAxis.VERTICAL,
            children = listOf(
                Form(
                    action = FormRemoteAction(
                        path = SUBMIT_FORM_ENDPOINT,
                        method = FormMethodType.POST
                    ),
                    child = Container(
                        children = listOf(
                            customFormInput(
                                name = "optional-field",
                                placeholder = "Optional field"
                            ),
                            customFormInput(
                                name = "required-field",
                                required = true,
                                validator = "text-is-not-blank",
                                placeholder = "Required field"
                            ),
                            customFormInput(
                                name = "another-required-field",
                                required = true,
                                validator = "text-is-not-blank",
                                placeholder = "Another required field"

                            ),
                            Container(
                                children = emptyList()
                            ).applyFlex(Flex(grow = 1.0)),
                            FormSubmit(
                                enabled = false,
                                child = Button(
                                    text = "Submit Form",
                                    style = BUTTON_STYLE_FORM
                                ).applyFlex(flexHorizontalMargin)
                            )
                        )
                    )
                        .applyFlex(
                            Flex(
                                grow = 1.0,
                                padding = EdgeValue(all = 10.unitReal())
                            )
                        )
                        .applyAppearance(Appearance(backgroundColor = LIGHT_GREEN))
                )
            )
        )
    )

    private fun customFormInput(
        name: String,
        required: Boolean? = null,
        validator: String? = null,
        placeholder: String
    ) =
        FormInput(
            name = name,
            required = required,
            validator = validator,
            child = SampleTextField(
                placeholder = placeholder
            ).applyFlex(flexHorizontalMargin)
        )
}