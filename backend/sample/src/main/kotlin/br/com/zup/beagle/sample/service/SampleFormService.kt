package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.sample.widget.SampleTextField
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
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
    fun creationFormView(): Screen {
        val flexHorizontalMargin =
            Flex(margin = EdgeValue(all = UnitValue(value = 10.0, type = UnitType.REAL)))
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
            content = Form(
                path = "/sample/form",
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
                                style = "DesignSystem.Form.Submit"
                            ).applyFlex(flexHorizontalMargin)
                        )
                    )
                )
                    .applyFlex(
                        Flex(
                            grow = 1.0,
                            padding = EdgeValue(all = UnitValue(value = 10.0, type = UnitType.REAL))
                        )
                    )
                    .applyAppearance(Appearance(backgroundColor = "#B8E297"))
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
