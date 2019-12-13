package br.com.zup.beagle.view

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import br.com.zup.beagle.R

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
            showScreen(context, url)
        } else {
            context.startActivity(BeagleUIActivity.newIntent(context, url))
        }
    }

    private fun showScreen(activity: AppCompatActivity, url: String) {
        val transaction = activity.supportFragmentManager
            .beginTransaction()
            .setCustomAnimations(
                R.anim.slide_from_right, R.anim.slide_to_right,
                R.anim.slide_from_right, R.anim.slide_to_right
            )
            .replace(R.id.beagle_content, BeagleUIFragment.newInstance(url))

        transaction.addToBackStack(url)
        transaction.commit()
    }

    fun swapScreen(context: Context, url: String) {
        context.startActivity(BeagleUIActivity.newIntent(context, url).apply {
            addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK or Intent.FLAG_ACTIVITY_NEW_TASK)
        })
    }

    fun popToScreen(context: Context, url: String) {
        if (context is AppCompatActivity) {
            context.supportFragmentManager
                .popBackStack(url, 0)
        }
    }

    fun presentScreen(context: Context, url: String) {
        context.startActivity(BeagleUIActivity.newIntent(context, url))
    }
}