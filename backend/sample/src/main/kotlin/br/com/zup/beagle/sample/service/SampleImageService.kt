package br.com.zup.beagle.sample.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.sample.constants.LOGO_BEAGLE
import br.com.zup.beagle.sample.constants.TITLE_SCREEN
import br.com.zup.beagle.widget.core.ImageContentMode
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleImageService {
    fun createImageView(): Screen {

        return Screen(
            navigationBar = NavigationBar(
                "Beagle Image",
                showBackButton = true,
                navigationBarItems = listOf(
                    NavigationBarItem(
                        text = "",
                        image = "informationImage",
                        action = ShowNativeDialog(
                            title = "Image",
                            message = "This widget will define a image view natively using the server driven " +
                                "information received through Beagle.",
                            buttonText = "OK"
                        )
                    )
                )
            ),
            child = ScrollView(
                scrollDirection = ScrollAxis.VERTICAL,
                children = listOf(
                    Text(text = "Image", style = TITLE_SCREEN),

                    Image(name = LOGO_BEAGLE),

                    Text(
                        text = "Image with contentMode = ImageContentMode.CENTER",
                        style = TITLE_SCREEN
                    ),

                    Image(name = LOGO_BEAGLE, contentMode = ImageContentMode.CENTER),

                    Text(
                        text = "Image with contentMode = ImageContentMode.CENTER_CROP",
                        style = TITLE_SCREEN
                    ),

                    Image(name = LOGO_BEAGLE, contentMode = ImageContentMode.CENTER_CROP),

                    Text(
                        text = "Image with contentMode = ImageContentMode.FIT_CENTER",
                        style = TITLE_SCREEN
                    ),

                    Image(name = LOGO_BEAGLE, contentMode = ImageContentMode.FIT_CENTER),

                    Text(
                        text = "Image with contentMode = ImageContentMode.FIT_XY",
                        style = TITLE_SCREEN
                    ),

                    Image(name = LOGO_BEAGLE, contentMode = ImageContentMode.FIT_XY)
                )
            )
        )
    }
}
