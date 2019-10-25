package br.com.zup.beagleui.framework.view

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import br.com.zup.beagleui.framework.data.repository.BeagleDataRepository
import br.com.zup.beagleui.framework.exception.BeagleDataException
import br.com.zup.beagleui.framework.testutil.getPrivateField
import br.com.zup.beagleui.framework.widget.core.Widget
import io.mockk.MockKAnnotations
import io.mockk.coEvery
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.test.setMain
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import kotlin.test.assertTrue

private const val SCREEN_URL = "screenUrl"

/*
class BeagleUIViewModelTest {

    @get:Rule
    val rule = InstantTaskExecutorRule()

    @MockK
    private lateinit var widget: Widget
    @MockK
    private lateinit var beagleDataRepository: BeagleDataRepository

    @InjectMockKs
    private lateinit var beagleUIViewModel: BeagleUIViewModel

    private val viewStateResult: (t: ViewState) -> Unit = {
        viewModelStates.add(it)
    }

    private var viewModelStates: MutableList<ViewState> = mutableListOf()

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        Dispatchers.setMain(Dispatchers.Unconfined)

        coEvery { beagleDataRepository.fetchWidget(any()) } returns widget

        viewModelStates.clear()

        beagleUIViewModel.state.observeForever(viewStateResult)
    }

    @After
    fun tearDown() {
        beagleUIViewModel.state.removeObserver(viewStateResult)
    }

    @Test
    fun initialize_should_set_screenUrl() {
        // Given
        val url = "http://test.com/test"

        // When
        beagleUIViewModel.initialize(url)

        // Then
        val screenUrl = beagleUIViewModel.getPrivateField<String>(SCREEN_URL)
        assertEquals(url, screenUrl)
    }

    @Test
    fun initialize_should_return_render_ViewState() {
        // Given
        val url = "http://test.com/test"

        // When
        beagleUIViewModel.initialize(url)

        // Then
        assertLoading(viewModelStates[0], true)
        assertEquals(widget, (viewModelStates[1] as ViewState.Render).widget)
        assertLoading(viewModelStates[2], false)
    }

    @Test
    fun initialize_should_return_a_error_ViewState() {
        // Given
        val url = "http://test.com/test"
        val exception = BeagleDataException("Error")
        coEvery { beagleDataRepository.fetchWidget(any()) } throws exception

        // When
        beagleUIViewModel.initialize(url)

        // Then
        assertLoading(viewModelStates[0], true)
        assertEquals(ViewState.Error, viewModelStates[1])
        assertLoading(viewModelStates[2], false)
    }

    private fun assertLoading(viewState: ViewState, expected: Boolean) {
        assertTrue(viewState is ViewState.Loading)
        assertEquals(expected, viewState.value)
    }
}*/
