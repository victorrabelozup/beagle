package br.com.zup.beagle.view

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.os.Parcelable
import android.view.WindowManager
import androidx.annotation.IdRes
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import br.com.zup.beagle.R
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.data.BeagleViewModel
import br.com.zup.beagle.data.ViewState
import br.com.zup.beagle.data.serializer.BeagleSerializer
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.utils.configureSupportActionBar
import br.com.zup.beagle.utils.toComponent
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenComponent
import kotlinx.android.parcel.Parcelize

sealed class ServerDrivenState {
    data class Error(val throwable: Throwable) : ServerDrivenState()
    class Loading(val loading: Boolean) : ServerDrivenState()
}

@Parcelize
data class ScreenRequest(
    val url: String,
    val method: ScreenMethod = ScreenMethod.GET,
    val headers: Map<String, String> = mapOf(),
    val body: String? = null
) : Parcelable

enum class ScreenMethod {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD,
    PATCH
}

private val beagleSerializer: BeagleSerializer = BeagleSerializer()
private const val FIRST_SCREEN_REQUEST_KEY = "FIRST_SCREEN_REQUEST_KEY"
private const val FIRST_SCREEN_KEY = "FIRST_SCREEN_KEY"

abstract class BeagleActivity : AppCompatActivity() {

    private val viewModel by lazy { ViewModelProviders.of(this)[BeagleViewModel::class.java] }
    private val screenRequest by lazy { intent.extras?.getParcelable<ScreenRequest>(FIRST_SCREEN_REQUEST_KEY) }
    private val screen by lazy { intent.extras?.getString(FIRST_SCREEN_KEY) }

    companion object {
        fun newIntent(context: Context, screenRequest: ScreenRequest, screen: Screen? = null): Intent {
            val activityClass = BeagleEnvironment.beagleSdk.serverDrivenActivity
            return Intent(context, activityClass).apply {
                putExtra(FIRST_SCREEN_REQUEST_KEY, screenRequest)
                screen?.let {
                    putExtra(FIRST_SCREEN_KEY, beagleSerializer.serializeComponent(screen.toComponent()))
                }
            }
        }
    }

    abstract fun getToolbar(): Toolbar

    @IdRes
    abstract fun getServerDrivenContainerId(): Int

    abstract fun onServerDrivenContainerStateChanged(state: ServerDrivenState)

    override fun onCreate(savedInstanceState: Bundle?) {
        BeagleEnvironment.beagleSdk.designSystem?.let {
            setTheme(it.theme())
        }

        super.onCreate(savedInstanceState)

        window.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE)

        viewModel.state.observe(this, Observer {
            when (it) {
                is ViewState.Error -> onServerDrivenContainerStateChanged(ServerDrivenState.Error(it.throwable))
                is ViewState.Loading -> onServerDrivenContainerStateChanged(ServerDrivenState.Loading(it.value))
                is ViewState.DoRender -> showScreen(it.screenId, it.component)
            }
        })
    }

    override fun onResume() {
        super.onResume()

        if (supportFragmentManager.fragments.size == 0) {
            screenRequest?.let {request ->
                screen?.let {
                    viewModel.fetchComponent(request, beagleSerializer.deserializeComponent(it) as ScreenComponent)
                } ?: run {
                    viewModel.fetchComponent(request)
                }
            }
        }

        if (supportActionBar == null) {
            configureSupportActionBar()
        }
    }

    override fun onBackPressed() {
        if (supportFragmentManager.backStackEntryCount == 1) {
            finish()
        } else {
            super.onBackPressed()
        }
    }

    fun navigateTo(screenRequest: ScreenRequest, screen: Screen?) {
        viewModel.fetchComponent(screenRequest, screen?.toComponent())
    }

    private fun showScreen(screenName: String?, component: ServerDrivenComponent) {
        val transaction = supportFragmentManager
            .beginTransaction()
            .setCustomAnimations(
                R.anim.slide_from_right, R.anim.none_animation,
                R.anim.none_animation, R.anim.slide_to_right
            )
            .replace(getServerDrivenContainerId(), BeagleFragment.newInstance(component))

        transaction.addToBackStack(screenName)
        transaction.commit()
    }
}