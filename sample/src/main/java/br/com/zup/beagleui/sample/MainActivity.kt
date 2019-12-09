package br.com.zup.beagleui.sample

import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import br.com.zup.beagleui.framework.utils.dp
import br.com.zup.beagleui.framework.view.BeagleUIActivity
import br.com.zup.beagleui.sample.activities.NavigationBarActivity
import br.com.zup.beagleui.sample.fragment.DynamicStatefulFragment
import br.com.zup.beagleui.sample.fragment.LazyWidgetFragment
import br.com.zup.beagleui.sample.fragment.ScrollViewFragment
import br.com.zup.beagleui.sample.fragment.StaticStatefulFragment
import br.com.zup.beagleui.sample.fragment.TextFieldFragment

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        supportActionBar?.apply {
            title = "Beagle Sample"
            elevation = 4.0f.dp()
        }
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.menu_navigation_drawer, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        menuSelected(itemSelected = item.itemId)
        return super.onOptionsItemSelected(item)
    }

    private fun menuSelected(itemSelected: Int) {
        when (itemSelected) {
            R.id.stateful -> goToFragment(StaticStatefulFragment.newInstance())
            R.id.textField -> goToFragment(TextFieldFragment.newInstance())
            R.id.scroll -> goToFragment(ScrollViewFragment.newInstance())
            R.id.lazywidget -> goToFragment(LazyWidgetFragment.newInstance())
            // Navigation Bar requires an activity without toolbar
            R.id.navigationBar -> startActivity(NavigationBarActivity.newIntent(this))
            R.id.stateful_dynamic -> goToFragment(DynamicStatefulFragment.newInstance())
            R.id.navigation -> startActivity(
                BeagleUIActivity.newIntent(
                    this,
                    "https://t001-2751a.firebaseapp.com/flow/step1.json"
                )
            )
        }
    }

    private fun goToFragment(fragment: Fragment) {
        val fragmentTransaction = supportFragmentManager.beginTransaction()
        fragmentTransaction.replace(R.id.fragment_content, fragment)
        fragmentTransaction.commit()
    }
}
