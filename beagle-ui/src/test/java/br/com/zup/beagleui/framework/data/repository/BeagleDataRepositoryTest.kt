package br.com.zup.beagleui.framework.data.repository

import br.com.zup.beagleui.framework.data.BeagleHttpClient
import br.com.zup.beagleui.framework.widget.core.Widget
import io.mockk.MockKAnnotations
import io.mockk.coEvery
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.slot
import kotlinx.coroutines.runBlocking
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

private const val URL = "http://www.mocky.io/v2/5d855b4b320000b90607b244"

class BeagleDataRepositoryTest {

    @MockK
    private lateinit var beagleHttpClient: BeagleHttpClient

    @MockK
    private lateinit var widget: Widget

    private val urlSlot = slot<String>()

    @InjectMockKs
    private lateinit var beagleDataRepository: BeagleDataRepository

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
        coEvery { beagleHttpClient.fetchWidget(capture(urlSlot)) } returns widget
    }

    @Test
    fun test() = runBlocking {
        val widgetResponse = beagleDataRepository.fetchWidget(URL)

        assertEquals(URL, urlSlot.captured)
        assertEquals(widget, widgetResponse)
    }
}