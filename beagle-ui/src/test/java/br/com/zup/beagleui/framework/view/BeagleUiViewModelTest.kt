package br.com.zup.beagleui.framework.view

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import br.com.zup.beagleui.framework.data.BeagleHttpClient
import br.com.zup.beagleui.framework.testutil.getPrivateField
import br.com.zup.beagleui.framework.widget.core.Widget
import io.mockk.MockKAnnotations
import io.mockk.coEvery
import io.mockk.impl.annotations.MockK
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.test.setMain
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*
import org.junit.Rule

private const val SCREEN_URL = "screenUrl"

class BeagleUiViewModelTest {

    @get:Rule
    val rule = InstantTaskExecutorRule()

    @MockK
    private lateinit var beagleHttpClient: BeagleHttpClient
    @MockK
    private lateinit var widget: Widget

    private lateinit var beagleUiViewModel: BeagleUiViewModel

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        Dispatchers.setMain(Dispatchers.Unconfined)

        beagleUiViewModel = BeagleUiViewModel(beagleHttpClient)

        coEvery { beagleHttpClient.fetchWidget(any()) } returns widget
    }

    @Test
    fun initialize() {
        // Given
        val url = "http://test.com/loginview"

        // When
        beagleUiViewModel.initialize(url)

        // Then
        val screenUrl = beagleUiViewModel.getPrivateField<String>(SCREEN_URL)
        assertEquals(url, screenUrl)
        assertEquals(widget, beagleUiViewModel.widgetToRender.value)
    }

    @Test
    fun initialize_should_call_beagleHttpClient_to_fetch_widget() {
        // Given
        val url = "http://test.com/loginview"

        // When
        beagleUiViewModel.initialize(url)

        // Then
        val screenUrl = beagleUiViewModel.getPrivateField<String>(SCREEN_URL)
        assertEquals(url, screenUrl)
        assertEquals(widget, beagleUiViewModel.widgetToRender.value)
    }
}