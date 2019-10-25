package br.com.zup.beagleui.framework.view

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import br.com.zup.beagleui.R

class BeagleNavigator(
    private val context: Context
) {

    fun finish() {
        if (context is BeagleUIActivity) {
            context.finish()
        }
    }

    fun pop() {
        if (context is BeagleUIActivity) {
            context.onBackPressed()
        }
    }

    fun addScreen(url: String) {
        if (context is BeagleUIActivity) {
            showScreen(context, url, true)
        }
    }

    fun openScreen(url: String) {
        if (context is BeagleUIActivity) {
            showScreen(context, url, false)
        }
    }

    private fun showScreen(activity: AppCompatActivity, url: String, addToStack: Boolean) {
        val transaction = activity.supportFragmentManager
            .beginTransaction()
            .setCustomAnimations(
                R.anim.slide_from_right, R.anim.slide_to_right,
                R.anim.slide_from_right, R.anim.slide_to_right
            )
            .replace(R.id.beagle_content, BeagleUIFragment.newInstance(url))

        if (addToStack) {
            transaction.addToBackStack(url)
        }

        transaction.commit()
    }
}