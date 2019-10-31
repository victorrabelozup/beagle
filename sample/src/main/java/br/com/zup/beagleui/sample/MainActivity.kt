package br.com.zup.beagleui.sample

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import br.com.zup.beagleui.framework.view.BeagleUIActivity
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        /*
        * Container com scroll na tela inteira
        * http://www.mocky.io/v2/5d854ba2320000690707b219
        */

        /*
        * Container com elementos que não dão scroll
        * http://www.mocky.io/v2/5d855b4b320000b90607b244
        */

        /*
        * Container com elementos que não dão scroll e sem footer
        * http://www.mocky.io/v2/5d88da4e33000020e6d7dc27
        */

        btFetchWidgets.setOnClickListener {
            startActivity(BeagleUIActivity.newIntent(this, "http://www.mocky.io/v2/5da9f2243100006b184e0c99"))
        }
    }
}
