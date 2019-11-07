package br.com.zup.beagleui.framework.view

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import br.com.zup.beagleui.framework.action.Action
import br.com.zup.beagleui.framework.data.BeagleService
import br.com.zup.beagleui.framework.data.BeagleViewModel
import br.com.zup.beagleui.framework.data.ViewState
import br.com.zup.beagleui.framework.exception.BeagleDataException
import br.com.zup.beagleui.framework.testutil.RandomData
import br.com.zup.beagleui.framework.utils.CoroutineDispatchers
import br.com.zup.beagleui.framework.widget.core.Widget
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.coEvery
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.spyk
import io.mockk.verify
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.cancel
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import kotlin.test.assertTrue

class BeagleViewModelTest {

    @get:Rule
    val rule = InstantTaskExecutorRule()

    @MockK
    private lateinit var widget: Widget
    @MockK
    private lateinit var action: Action
    @MockK
    private lateinit var beagleService: BeagleService

    @InjectMockKs
    private lateinit var beagleUIViewModel: BeagleViewModel

    private val viewStateResult: (t: ViewState) -> Unit = {
        viewModelStates.add(it)
    }

    private var viewModelStates: MutableList<ViewState> = mutableListOf()

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        CoroutineDispatchers.Main = Dispatchers.Unconfined

        coEvery { beagleService.fetchWidget(any()) } returns widget
        coEvery { beagleService.fetchAction(any()) } returns action

        viewModelStates.clear()

        beagleUIViewModel.state.observeForever(viewStateResult)
    }

    @After
    fun tearDown() {
        beagleUIViewModel.state.removeObserver(viewStateResult)
    }

    @Test
    fun fetchWidget_should_return_render_ViewState() {
        // Given
        val url = RandomData.httpUrl()

        // When
        beagleUIViewModel.fetchWidget(url)

        // Then
        assertLoading(viewModelStates[0], true)
        assertEquals(widget, (viewModelStates[1] as ViewState.Result<Widget>).data)
        assertLoading(viewModelStates[2], false)
    }

    @Test
    fun fetchWidget_should_return_a_error_ViewState() {
        // Given
        val url = RandomData.httpUrl()
        val exception = BeagleDataException("Error")
        coEvery { beagleService.fetchWidget(any()) } throws exception

        // When
        beagleUIViewModel.fetchWidget(url)

        // Then
        assertLoading(viewModelStates[0], true)
        assertEquals(ViewState.Error, viewModelStates[1])
        assertLoading(viewModelStates[2], false)
    }

    @Test
    fun fetchAction_should_return_render_ViewState() {
        // Given
        val url = RandomData.httpUrl()

        // When
        beagleUIViewModel.fetchAction(url)

        // Then
        assertLoading(viewModelStates[0], true)
        assertEquals(action, (viewModelStates[1] as ViewState.Result<Action>).data)
        assertLoading(viewModelStates[2], false)
    }

    @Test
    fun fetchAction_should_return_a_error_ViewState() {
        // Given
        val url = RandomData.httpUrl()
        val exception = BeagleDataException("Error")
        coEvery { beagleService.fetchAction(any()) } throws exception

        // When
        beagleUIViewModel.fetchAction(url)

        // Then
        assertLoading(viewModelStates[0], true)
        assertEquals(ViewState.Error, viewModelStates[1])
        assertLoading(viewModelStates[2], false)
    }

    @Test
    fun onCleared_should_call_cancel() {
        // Given
        val viewModelSpy = spyk(beagleUIViewModel)
        every { viewModelSpy.cancel() } just Runs

        // When
        viewModelSpy.onCleared()

        // Then
        verify(exactly = 1) { viewModelSpy.cancel() }
    }

    private fun assertLoading(viewState: ViewState, expected: Boolean) {
        assertTrue(viewState is ViewState.Loading)
        assertEquals(expected, viewState.value)
    }
}
