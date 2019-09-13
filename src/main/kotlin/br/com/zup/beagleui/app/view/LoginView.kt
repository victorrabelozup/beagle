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
        return Container(
            header = Vertical(
                children = listOf(
                    buildToolbar(),
                    buildSelectView()
                )
            ),
            content = Vertical(
                flex = Flex(justifyContent = JustifyContent.CENTER),
                children = listOf(
                    InvoiceChart(),
                    Spacer(20.0),
                    Horizontal(
                        children = listOf(
                            Text("Vencimento 10 de Out"),
                            Spacer(5.0),
                            Image("arrow.png")
                        )
                    ),
                    Spacer(4.0),
                    Text("Compras até 20 de set"),
                    Spacer(15.0),
                    Button("Pagar Fatura"),
                    buildOpenInvoice(),
                    Spacer(20.0),
                    Image("plus.png"),
                    Spacer(20.0),
                    buildLastInvoice(),
                    Spacer(20.0),
                    Image("equal.png")
                )
            )
        )
    }

    private fun buildToolbar(): Widget {
        return Toolbar(
            title = "Lançamentos"
        )
    }

    private fun buildSelectView(): Widget {
        return SelectView(
            size = 10,
            rowBuilder = {
                Horizontal(
                    flex = Flex(
                        justifyContent = JustifyContent.SPACE_BETWEEN
                    ),
                    children = listOf(
                        Horizontal(
                            children = listOf(
                                Image("cartao-free.png"),
                                Vertical(
                                    children = listOf(
                                        Text("FREE"),
                                        Text("Múltiplo | MASTER | 4515")
                                    )
                                )
                            )
                        ),
                        Image("arrow-down.png")
                    )
                )
            }
        )
    }

    private fun buildOpenInvoice(): Widget {
        return DropDown(
            header = Horizontal(
                flex = Flex(justifyContent = JustifyContent.SPACE_BETWEEN),
                children = listOf(
                    Text("Lançamentos\nem aberto"),
                    Horizontal(
                        children = listOf(
                            Text("R$ 896,80"),
                            Image("circle-arrow-down.png")
                        )
                    )
                )
            ),
            child = buildInvoiceList()
        )
    }

    private fun buildInvoiceList(): Widget {
        return ListView(
            size = 10,
            rowBuilder = { index ->
                if (index == 0) {
                    Horizontal(
                        flex = Flex(justifyContent = JustifyContent.SPACE_BETWEEN),
                        children = listOf(
                            Text("Final 8199"),
                            Text("R$ 73,92")
                        )
                    )
                }

                Horizontal(
                    children = listOf(
                        Vertical(
                            children = listOf(
                                Text("27/02/2019"),
                                Text("Bretas")
                            )
                        ),
                        Vertical(
                            children = listOf(
                                Text("Parcela 07 de 12"),
                                Text("R$ 100,00")
                            )
                        )
                    )
                )
            }
        )
    }

    private fun buildLastInvoice(): Widget {
        return DropDown(
            header = Horizontal(
                flex = Flex(justifyContent = JustifyContent.SPACE_BETWEEN),
                children = listOf(
                    Text("Saldo\nfatura anterior"),
                    Horizontal(
                        children = listOf(
                            Text("R$ 896,80"),
                            Image("circle-arrow-down.png")
                        )
                    )
                )
            ),
            child = buildInvoiceList()
        )
    }
}
