package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.Spacer
import br.com.zup.beagle.widget.ui.ListDirection
import br.com.zup.beagle.widget.ui.ListView
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleListViewService {
    fun creationListView(): Screen {

        return Screen(
            navigationBar = NavigationBar(
                "Beagle ListView",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "ListView",
                            message = "Is a Layout component that will define a list of views natively. " +
                                "These views could be any Server Driven Component.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            content = Container(
                children = listOf(
                    getStaticVerticalListView(),
                    Spacer(20.0),
                    getStaticHorizontalListView(),
                    Spacer(20.0),
                    getDynamicVerticalListView(),
                    Spacer(20.0),
                    getDynamicHorizontalListView()
                )
            )
        )
    }

    private fun getStaticVerticalListView(): Container {
        return Container(
            children = listOf(
                Text("Static Vertical ListView"),
                Spacer(10.0),
                ListView(
                    rows = listOf(
                        Text("Hello 1"),
                        Text("Hello 2"),
                        Text("Hello 3"),
                        Text("Hello 4"),
                        Text("Hello 5")
                    ),
                    direction = ListDirection.VERTICAL
                )
            )
        )
    }

    private fun getStaticHorizontalListView(): Container {
        return Container(
            children = listOf(
                Text("Static Horizontal ListView"),
                Spacer(10.0),
                ListView(
                    rows = listOf(
                        Text("Hello 1"),
                        Text("Hello 2"),
                        Text("Hello 3"),
                        Text("Hello 4"),
                        Text("Hello 5")
                    ),
                    direction = ListDirection.HORIZONTAL
                )
            )
        )
    }

    private fun getDynamicVerticalListView(): Container {
        return Container(
            children = listOf(
                Text("Dynamic Vertical ListView"),
                Spacer(10.0),
                ListView.dynamic(
                    size = 20,
                    direction = ListDirection.VERTICAL,
                    rowBuilder = { index ->
                        Text("Hello $index")
                    }
                )
            )
        )
    }

    private fun getDynamicHorizontalListView(): Container {
        return Container(
            children = listOf(
                Text("Dynamic Horizontal ListView"),
                Spacer(10.0),
                ListView.dynamic(
                    size = 20,
                    direction = ListDirection.HORIZONTAL,
                    rowBuilder = { index ->
                        Text("Hello $index")
                    }
                )
            )
        )
    }
}
