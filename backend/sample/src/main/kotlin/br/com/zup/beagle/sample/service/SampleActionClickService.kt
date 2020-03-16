package br.com.zup.beagle.sample.service

import br.com.zup.beagle.sample.constants.SCREEN_ACTION_CLICK_ENDPOINT
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleActionClickService {
    fun createActionClick(): Screen {
        return Screen(
            navigationBar = NavigationBar(
                "Action Click",
                showBackButton = true
            ),
            child = Container(
                children = listOf(
                    Text(
                        text = "You clicked right",
                        style = SCREEN_ACTION_CLICK_ENDPOINT
                    ).applyFlex(
                        flex = Flex(
                            justifyContent = JustifyContent.CENTER,
                            alignItems = Alignment.CENTER
                        )
                    )
                )
            )
        )
    }
}