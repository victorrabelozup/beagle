/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.Action
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
import br.com.zup.beagle.widget.form.FormSubmit
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.Button
import org.springframework.stereotype.Service
import org.springframework.web.bind.annotation.RequestBody

@Service
class SampleFormService {
    fun createFormView(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                "Form",
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
                path = SUBMIT_FORM_ENDPOINT,
                method = FormMethodType.POST,
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
                            ).applyFlex(Flex(margin = EdgeValue(all = 10.unitReal())))
                        )
                    )
                ).applyFlex(
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
    }

    fun submitForm(@RequestBody body: Map<String, String>): Action {
        val params = body.keys.joinToString(separator = "\n") { "${it}: ${body[it]}" }
        return ShowNativeDialog(
            title = "Success!",
            message = params,
            buttonText = "Ok"
        )
    }

    private fun customFormInput(
        name: String,
        required: Boolean? = null,
        validator: String? = null,
        placeholder: String
    ) = FormInput(
            name = name,
            required = required,
            validator = validator,
            child = SampleTextField(
                placeholder = placeholder
            ).applyFlex(Flex(margin = EdgeValue(all = 10.unitReal())))
    )
}
