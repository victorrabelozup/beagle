/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.preview

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.appcompat.widget.Toolbar
import br.com.zup.beagle.utils.renderScreen
import br.com.zup.beagle.view.BeagleActivity
import br.com.zup.beagle.view.ServerDrivenState
import kotlinx.android.synthetic.main.activity_preview.*
import okhttp3.Response
import okhttp3.WebSocket
import okhttp3.WebSocketListener

private const val ENDPOINT_KEY = "ENDPOINT_KEY"
private const val TAG = "BeagleSDK"

class PreviewActivity : BeagleActivity() {

    companion object {
        fun newIntent(context: Context): Intent {
            return Intent(context, PreviewActivity::class.java)
        }
    }

    private lateinit var beaglePreview: BeaglePreview

    override fun getToolbar(): Toolbar = tPreview

    override fun getServerDrivenContainerId() = R.id.flPreview

    override fun onServerDrivenContainerStateChanged(state: ServerDrivenState) {}

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_preview)

        beaglePreview = BeaglePreview(intent.extras?.getString(ENDPOINT_KEY))

        beaglePreview.start(object : WebSocketListener() {
            override fun onOpen(webSocket: WebSocket, response: Response) {
                super.onOpen(webSocket, response)
                Log.d(TAG, "onOpen: ${response.message}")
            }

            override fun onMessage(webSocket: WebSocket, text: String) {
                super.onMessage(webSocket, text)
                Log.d(TAG, "onMessage: $text")
                runOnUiThread {
                    if (!text.startsWith("Welcome")) {
                        flPreview.renderScreen(context = this@PreviewActivity, screenJson = text)
                    } else {
                        Toast.makeText(this@PreviewActivity, text, Toast.LENGTH_SHORT).show()
                    }
                }
            }

            override fun onClosing(webSocket: WebSocket, code: Int, reason: String) {
                super.onClosing(webSocket, code, reason)
                Log.d(TAG, "onClosing: $reason")
            }

            override fun onClosed(webSocket: WebSocket, code: Int, reason: String) {
                super.onClosed(webSocket, code, reason)
                Log.d(TAG, "onClosed: $reason")
            }

            override fun onFailure(webSocket: WebSocket, t: Throwable, response: Response?) {
                super.onFailure(webSocket, t, response)
                Log.e(TAG, "onFailure: webSocket closed")
            }
        })
    }

    override fun onDestroy() {
        super.onDestroy()
        beaglePreview.close()
    }
}