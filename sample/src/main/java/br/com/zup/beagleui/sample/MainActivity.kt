package br.com.zup.beagleui.sample

import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import br.com.zup.beagleui.sample.fragment.StatefulFragment

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        // Get the support action bar
        val actionBar = supportActionBar

        // Set the action bar title and elevation
        actionBar!!.title = "Beagle Sample"
        actionBar.elevation = 4.0F
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
            R.id.stateful -> goToFragment(StatefulFragment.newInstance())

            else -> {
            }
        }
    }

    private fun goToFragment(fragment: Fragment) {
        val fragmentTransaction = supportFragmentManager.beginTransaction()
        fragmentTransaction.replace(R.id.fragment_content, fragment)
        fragmentTransaction.commit()
    }

}
