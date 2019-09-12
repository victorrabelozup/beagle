package br.com.zup.beagleui.sample

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import br.com.zup.beagleui.view.BeagleUiActivity

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        startActivity(BeagleUiActivity.newIntent(this, "http://www.mocky.io/v2/5d798115320000520034ea4c"))
    }
}
