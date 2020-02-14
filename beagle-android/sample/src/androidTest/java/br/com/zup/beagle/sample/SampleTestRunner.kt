package br.com.zup.beagle.sample

import com.facebook.testing.screenshot.ScreenshotRunner
import android.os.Bundle
import androidx.test.runner.AndroidJUnitRunner

class SampleTestRunner : AndroidJUnitRunner() {
    override fun onCreate(args: Bundle) {
        ScreenshotRunner.onCreate(this, args)
        super.onCreate(args)
    }

    override fun finish(resultCode: Int, results: Bundle) {
        ScreenshotRunner.onDestroy()
        super.finish(resultCode, results)
    }
}