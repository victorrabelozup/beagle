package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.sample.widgets.MutableText
import br.com.zup.beagle.sample.widgets.TextField
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.form.Form
import br.com.zup.beagle.widget.form.FormInput
import br.com.zup.beagle.widget.form.FormMethodType
import br.com.zup.beagle.widget.form.FormSubmit
import br.com.zup.beagle.widget.layout.FlexSingleWidget
import br.com.zup.beagle.widget.layout.FlexWidget
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text
import br.com.zup.beagle.widget.ui.TextAlignment

class DisabledFormSubmitFragment : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        val declarative = makeCharade(
            CharadeInput(
                name = "mary",
                charade = "Mary's mum has 4 children. 1st child's name is April, 2nd child's name" +
                        " is May, 3rd child's name is June. Then what is the name of the 4th child?",
                validator = "Charade"
            )
        )

        return declarative.toView(this)
    }

    private fun makeCharade(charade: CharadeInput): Form {
        return Form(
            child = FlexWidget(
                children = listOf(
                    makeCharadeText(charade),
                    makeCharadeAnswer(),
                    makeCharadeAnswerInput(charade),
                    makeCharadeFormSubmit()
                )
            ),
            method = FormMethodType.POST,
            action = "endereco/endpoint"
        )
    }

    private fun makeCharadeFormSubmit(): FlexSingleWidget {
        return FlexSingleWidget(
            flex = Flex(
                alignSelf = Alignment.CENTER,
                size = Size(
                    width = UnitValue(95.0, UnitType.PERCENT)
                ),
                margin = EdgeValue(
                    top = UnitValue(15.0, UnitType.REAL)
                )
            ),
            child = FormSubmit(
                child = Button(text = "flag"),
                enabled = false
            )
        )
    }

    private fun makeCharadeAnswerInput(charade: CharadeInput): FlexSingleWidget {
        return FlexSingleWidget(
            flex = Flex(
                margin = EdgeValue(
                    top = UnitValue(10.0, UnitType.REAL)
                ),
                size = Size(
                    width = UnitValue(92.0, UnitType.PERCENT)
                ),
                alignSelf = Alignment.CENTER
            ),
            child = FormInput(
                name = charade.name,
                child = TextField(
                    hint = "answer"
                ),
                validator = charade.validator
            )
        )
    }

    private fun makeCharadeAnswer(): FlexSingleWidget {
        return FlexSingleWidget(
            flex = Flex(
                alignSelf = Alignment.CENTER,
                margin = EdgeValue(
                    top = UnitValue(5.0, UnitType.REAL)
                )
            ),
            child = MutableText(
                firstText = "show answer",
                secondText = "Mary",
                color = "#3380FF"
            )
        )
    }

    private fun makeCharadeText(charade: CharadeInput): FlexSingleWidget {
        return FlexSingleWidget(
            flex = Flex(
                alignSelf = Alignment.CENTER,
                margin = EdgeValue(
                    top = UnitValue(45.0, UnitType.REAL),
                    start = UnitValue(10.0, UnitType.REAL),
                    end = UnitValue(10.0, UnitType.REAL)
                )
            ),
            child = Text(
                text = charade.charade,
                alignment = TextAlignment.CENTER
            )
        )
    }

    companion object {
        fun newInstance(): DisabledFormSubmitFragment {
            return DisabledFormSubmitFragment()
        }
    }
}

data class CharadeInput(
    val name: String = "",
    val charade: String = "",
    val validator: String = ""
)