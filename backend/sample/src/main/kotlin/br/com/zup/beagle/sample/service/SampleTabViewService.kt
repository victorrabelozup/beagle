package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.sample.constants.BEACH_NETWORK_IMAGE
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.NetworkImage
import br.com.zup.beagle.widget.ui.TabItem
import br.com.zup.beagle.widget.ui.TabView
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleTabViewService {
    fun createTabView(): Screen {
        val tab1 = TabItem(
            title = "Tab 1",
            content = Container(
                children = listOf(
                    Text("Text1 Tab 2"),
                    NetworkImage(BEACH_NETWORK_IMAGE),
                    Text("Text2 Tab 2")
                )
            ).applyFlex(Flex(alignContent = Alignment.CENTER))
        )

        val tab2 = TabItem(
            title = "Tab 2",
            content = Container(
                children = listOf(
                    Text("Text1 Tab 2"),
                    Text("Text2 Tab 2")
                )
            ).applyFlex(Flex(alignContent = Alignment.CENTER))
        )

        val tab3 = TabItem(
            title = "Tab 3",
            content = Container(
                children = listOf(
                    Text("Text1 Tab 3"),
                    Text("Text2 Tab 3")
                )
            ).applyFlex(Flex(alignContent = Alignment.CENTER))
        )

        val tab4 = TabItem(
            title = "Tab 4",
            icon = "beagle",
            content = Container(
                children = listOf(
                    Text("Text1 Tab 4"),
                    Text("Text2 Tab 4")
                )
            ).applyFlex(Flex(alignContent = Alignment.CENTER))
        )

        return Screen(
            navigationBar = NavigationBar(
                "Beagle TabView",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "TabView",
                            message = " Is a component that will make the navigation between views. It may happen by " +
                                "sliding through screens or by clicking at the tabs shown. ",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            child = TabView(
                tabItems = listOf(tab1, tab2, tab3, tab4)
            )
        )


    }

}
