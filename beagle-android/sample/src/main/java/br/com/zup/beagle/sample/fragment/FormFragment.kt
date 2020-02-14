package br.com.zup.beagleui.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.sample.widgets.TextField
import br.com.zup.beagle.sample.widgets.TextFieldInputType
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.form.Form
import br.com.zup.beagle.widget.form.FormInput
import br.com.zup.beagle.widget.form.FormMethodType
import br.com.zup.beagle.widget.form.FormSubmit
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.ui.Button


class FormFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Container(
            children = listOf(
                Form(
                    child = Container(
                        children = listOf(
                            FormInput(
                                name = "nome",
                                child = TextField(
                                    hint = "nome"
                                )
                            ),
                            FormInput(
                                name = "email",
                                child = TextField(
                                    hint = "email"
                                )
                            ),
                            FormInput(
                                name = "senha",
                                child = TextField(
                                    hint = "senha",
                                    inputType = TextFieldInputType.PASSWORD
                                )
                            ),
                            FormSubmit(
                                child = Button(
                                    text = "submit"
                                )
                            )
                        )
                    ),
                    method = FormMethodType.POST,
                    path = "endereco/endpoint"
                )
            )
        )


        return declarative.toView(this)
    }

    companion object {
        fun newInstance(): FormFragment {
            return FormFragment()
        }
    }
}
