package br.com.zup.beagle.data

import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.action.NavigationType.ADD_VIEW
import br.com.zup.beagle.action.NavigationType.PRESENT_VIEW
import br.com.zup.beagle.action.NavigationType.SWAP_VIEW
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.testutil.RandomData
import br.com.zup.beagle.utils.generateViewModelInstance
import io.mockk.MockKAnnotations
import io.mockk.called
import io.mockk.coEvery
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.unmockkStatic
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

class PreFetchHelperTest {

    private val helper = PreFetchHelper()
    @MockK
    private lateinit var rootView: RootView
    private val cachedTypes =
        listOf(
            ADD_VIEW,
            SWAP_VIEW,
            PRESENT_VIEW
        )

    private val anyNavigationType = mockk<NavigationType>()

    @MockK
    private lateinit var beagleViewModel: BeagleViewModel

    @Before
    fun setup() {
        MockKAnnotations.init(this, relaxUnitFun = true)
        mockkStatic("br.com.zup.beagle.utils.ViewExtensionsKt")

        every { rootView.generateViewModelInstance() } returns beagleViewModel
        coEvery { beagleViewModel.fetchForCache(any()) } returns mockk()
    }

    @After
    fun tearDown() {
        unmockkStatic("br.com.zup.beagle.utils.ViewExtensionsKt")
    }

    @Test
    fun should_call_fetch_for_cache_test() {
        cachedTypes.forEach {
            val url = RandomData.string()
            helper.handlePreFetch(rootView, Navigate(type = it, path = url))
            verify(exactly = once()) { beagleViewModel.fetchForCache(url) }
        }
    }

    @Test
    fun should_not_call_fetch_for_cache_test() {
        cachedTypes.forEach {
            val url = RandomData.string()
            helper.handlePreFetch(rootView, Navigate(type = it, path = url))
            verify { beagleViewModel.fetchForCache(url) wasNot called }
        }
    }
}