package br.com.zup.beagleui.framework.view

import android.app.Activity
import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import br.com.zup.beagleui.R

internal object BeagleNavigator {

    fun finish(context: Context) {
        if (context is Activity) {
            context.finish()
        }
    }

    fun pop(context: Context) {
        if (context is Activity) {
            context.onBackPressed()
        }
    }

    fun addScreen(context: Context, url: String) {
        if (context is BeagleUIActivity) {
            showScreen(context, url, true)
        } else {
            context.startActivity(BeagleUIActivity.newIntent(context, url))
        }
    }

    fun openScreen(context: Context, url: String) {
        if (context is BeagleUIActivity) {
            showScreen(context, url, false)
        } else {
            context.startActivity(BeagleUIActivity.newIntent(context, url))
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