package br.com.zup.beagleui.sample

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import br.com.zup.beagleui.framework.view.BeagleUiActivity
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        btFetchWidgets.setOnClickListener {
            startActivity(BeagleUiActivity.newIntent(this, "http://www.mocky.io/v2/5d798115320000520034ea4c"))
        }
    }
}
