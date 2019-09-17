package br.com.zup.beagleui.app.view

import br.com.zup.beagleui.app.widget.InvoiceChart
import br.com.zup.beagleui.framework.core.*
import br.com.zup.beagleui.framework.layout.Container
import br.com.zup.beagleui.framework.layout.Horizontal
import br.com.zup.beagleui.framework.layout.Spacer
import br.com.zup.beagleui.framework.layout.Vertical
import br.com.zup.beagleui.framework.ui.*

class LoginView : Screen {
    override fun build(): Container {
        val emailId = "email"
        val passwordId = "password"

        return Container(
            content = Vertical(
                flex = Flex(alignContent = Alignment.CENTER),
                children = listOf(
                    TextField(
                        id = emailId,
                        hint = "E-mail",
                        type = TextFieldType.EMAIL,
                        validation = EmailValidation()
                    ),
                    Spacer(10.0),
                    TextField(
                        id = passwordId,
                        hint = "Password",
                        type = TextFieldType.PASSWORD,
                        validation = EmailValidation()
                    ),
                    Spacer(20.0),
                    Button(
                        text = "Entrar",
                        action = listOf(
                            ValidationAction(ids = listOf(emailId, passwordId)),
                            NavigationAction(uri = "/home")
                        )
                    )
                )
            )
        )
    }
}
