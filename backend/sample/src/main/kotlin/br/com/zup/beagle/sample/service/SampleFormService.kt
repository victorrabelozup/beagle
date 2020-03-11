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
import br.com.zup.beagle.widget.ui.Button
import org.springframework.stereotype.Service
import org.springframework.web.bind.annotation.RequestBody

@Service
class SampleFormService {
    fun createFormView(): Screen {
        val flexHorizontalMargin =
            Flex(margin = EdgeValue(all = 10.unitReal()))
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
            child = Form(
                path = SUBMIT_FORM_ENDPOINT,
                method = FormMethodType.POST,
                child = Container(
                    children = listOf(
                        FormInput(
                            name = "optional-field",
                            child = SampleTextField(
                                placeholder = "Optional field"
                            ).applyFlex(flexHorizontalMargin)
                        ),
                        FormInput(
                            name = "required-field",
                            required = true,
                            validator = "text-is-not-blank",
                            child = SampleTextField(
                                placeholder = "Required field"
                            ).applyFlex(flexHorizontalMargin)
                        ),
                        FormInput(
                            name = "another-required-field",
                            required = true,
                            validator = "text-is-not-blank",
                            child = SampleTextField(
                                placeholder = "Another required field"
                            ).applyFlex(flexHorizontalMargin)
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
    }


    fun submitForm(@RequestBody body: Map<String, String>): Action {
        val params = body.keys.joinToString(separator = "\n") { "${it}: ${body[it]}" }
        return ShowNativeDialog(
            title = "Success!",
            message = params,
            buttonText = "Ok"
        )
    }
}
