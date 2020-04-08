/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample

import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import br.com.zup.beagle.preview.PreviewActivity
import br.com.zup.beagle.sample.activities.NavigationBarActivity
import br.com.zup.beagle.sample.constants.SAMPLE_ENDPOINT
import br.com.zup.beagle.sample.fragment.ComposeComponentFragment
import br.com.zup.beagle.sample.fragment.DisabledFormSubmitFragment
import br.com.zup.beagle.sample.fragment.FormFragment
import br.com.zup.beagle.sample.fragment.ImageViewFragment
import br.com.zup.beagle.sample.fragment.LazyComponentFragment
import br.com.zup.beagle.sample.fragment.ListViewFragment
import br.com.zup.beagle.sample.fragment.NavigationFragment
import br.com.zup.beagle.sample.fragment.PageViewFragment
import br.com.zup.beagle.sample.fragment.ScrollViewFragment
import br.com.zup.beagle.sample.fragment.StackViewFragment
import br.com.zup.beagle.sample.fragment.TabViewFragment
import br.com.zup.beagle.sample.fragment.TextFieldFragment
import br.com.zup.beagle.sample.fragment.WebViewFragment
import br.com.zup.beagle.utils.dp
import br.com.zup.beagle.view.BeagleActivity
import br.com.zup.beagle.view.ScreenRequest

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
            R.id.textField -> goToFragment(TextFieldFragment.newInstance())
            R.id.scroll -> goToFragment(ScrollViewFragment.newInstance())
            R.id.lazycomponent -> goToFragment(LazyComponentFragment.newInstance())
            R.id.image -> goToFragment(ImageViewFragment.newInstance())
            R.id.pageView -> goToFragment(PageViewFragment.newInstance())
            // Navigation Bar requires an activity without toolbar
            R.id.navigationBar -> startActivity(NavigationBarActivity.newIntent(this))
            R.id.navigationFragment -> goToFragment(NavigationFragment.newInstance())
            R.id.navigation -> startActivity(
                BeagleActivity.newIntent(
                    this,
                    ScreenRequest("https://t001-2751a.firebaseapp.com/flow/step1.json")
                )
            )
            R.id.form -> goToFragment(FormFragment.newInstance())
            R.id.stack -> goToFragment(StackViewFragment.newInstance())
            R.id.tabBar -> goToFragment(TabViewFragment.newInstance())
            R.id.disabledFormSubmit -> goToFragment(DisabledFormSubmitFragment.newInstance())
            R.id.accessibility -> startActivity(BeagleActivity.newIntent(
                this,
                ScreenRequest("http://www.mocky.io/v2/5e4d46952d0000339ec0dce1")
            ))
            R.id.listView -> goToFragment(ListViewFragment.newInstance())
            R.id.webView -> goToFragment(WebViewFragment.newInstance())
            R.id.composeComponent -> goToFragment(ComposeComponentFragment.newInstance())
            R.id.sampleBff -> startActivity(BeagleActivity.newIntent(
                this,
                ScreenRequest(SAMPLE_ENDPOINT)
            ))
            R.id.preview -> startActivity(PreviewActivity.newIntent(this))
        }
    }

    private fun goToFragment(fragment: Fragment) {
        val fragmentTransaction = supportFragmentManager.beginTransaction()
        fragmentTransaction.replace(R.id.fragment_content, fragment)
        fragmentTransaction.commit()
    }
}
