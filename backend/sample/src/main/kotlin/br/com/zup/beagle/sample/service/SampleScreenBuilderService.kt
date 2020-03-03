package br.com.zup.beagle.sample.service

import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.ui.Text
import org.springframework.stereotype.Service

@Service
class SampleScreenBuilderService {
    fun createScreenBuilder(): ScreenBuilder = MyScreenBuilder("Hello World!")
}

private data class MyScreenBuilder(
    val title: String
) : ScreenBuilder {
    override fun build() = Screen(
        content = Text(title)
    )
}