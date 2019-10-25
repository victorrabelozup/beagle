package br.com.zup.beagleui.framework.view

import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentTransaction
import br.com.zup.beagleui.R
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.mockkStatic
import io.mockk.verify
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

private const val URL = "http://test.com/test"

class BeagleNavigatorTest {

    @MockK
    private lateinit var context: BeagleUIActivity
    @MockK
    private lateinit var fragmentTransaction: FragmentTransaction
    @MockK
    private lateinit var fragment: BeagleUIFragment

    @InjectMockKs
    private lateinit var navigator: BeagleNavigator

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkObject(BeagleUIFragment.Companion)

        every { BeagleUIFragment.newInstance(any()) } returns fragment

        val supportFragmentManager = mockk<FragmentManager>()
        every { context.supportFragmentManager } returns supportFragmentManager
        every { supportFragmentManager.beginTransaction() } returns fragmentTransaction
        every { fragmentTransaction.setCustomAnimations(any(), any(), any(), any()) } returns fragmentTransaction
        every { fragmentTransaction.replace(any(), any()) } returns fragmentTransaction
        every { fragmentTransaction.addToBackStack(any()) } returns fragmentTransaction
        every { fragmentTransaction.commit() } returns 0
    }

    @Test
    fun finish_should_call_finish_activity() {
        // Given
        every { context.finish() } just Runs

        // When
        navigator.finish()

        // Then
        verify(exactly = 1) { context.finish() }
    }

    @Test
    fun pop_should_call_activity_onBackPressed() {
        // Given
        every { context.onBackPressed() } just Runs

        // When
        navigator.pop()

        // Then
        verify(exactly = 1) { context.onBackPressed() }
    }

    @Test
    fun addScreen_should_set_customAnimations() {
        navigator.addScreen(URL)

        verify(exactly = 1) {
            fragmentTransaction.setCustomAnimations(
                R.anim.slide_from_right, R.anim.slide_to_right,
                R.anim.slide_from_right, R.anim.slide_to_right
            )
        }
    }

    @Test
    fun addScreen_should_replace_fragment_with_beagle_content() {
        navigator.addScreen(URL)

        verify(exactly = 1) {
            fragmentTransaction.replace(R.id.beagle_content, fragment)
        }
        verify(exactly = 1) { BeagleUIFragment.newInstance(URL) }
    }

    @Test
    fun addScreen_should_addToBackStack_with_given_url() {
        navigator.addScreen(URL)

        verify(exactly = 1) { fragmentTransaction.addToBackStack(URL) }
    }

    @Test
    fun addScreen_should_commit_transaction() {
        navigator.addScreen(URL)

        verify(exactly = 1) { fragmentTransaction.commit() }
    }

    @Test
    fun openScreen_should_set_customAnimations() {
        navigator.openScreen(URL)

        verify(exactly = 1) {
            fragmentTransaction.setCustomAnimations(
                R.anim.slide_from_right, R.anim.slide_to_right,
                R.anim.slide_from_right, R.anim.slide_to_right
            )
        }
    }

    @Test
    fun openScreen_should_replace_fragment_with_beagle_content() {
        navigator.openScreen(URL)

        verify(exactly = 1) {
            fragmentTransaction.replace(R.id.beagle_content, fragment)
        }
        verify(exactly = 1) { BeagleUIFragment.newInstance(URL) }
    }

    @Test
    fun openScreen_should_addToBackStack_with_given_url() {
        navigator.openScreen(URL)

        verify(exactly = 0) { fragmentTransaction.addToBackStack(URL) }
    }

    @Test
    fun openScreen_should_commit_transaction() {
        navigator.openScreen(URL)

        verify(exactly = 1) { fragmentTransaction.commit() }
    }
}