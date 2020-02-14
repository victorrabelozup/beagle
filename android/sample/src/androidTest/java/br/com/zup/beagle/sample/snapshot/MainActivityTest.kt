package br.com.zup.beagle.sample.snapshot

import android.content.Intent
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.rule.ActivityTestRule
import br.com.zup.beagle.sample.MainActivity
import com.facebook.testing.screenshot.Screenshot
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Instrumented test, which will execute on an Android device.
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
@RunWith(AndroidJUnit4::class)
class MainActivityTest {

    @Rule
    @JvmField
    val rule = ActivityTestRule(MainActivity::class.java, true, false)

    @Test
    fun testSnapshot() {
        rule.launchActivity(Intent())

//        val view = rule.activity.window.decorView.rootView

        Screenshot.snapActivity(rule.activity)
            .record()

    }
}
