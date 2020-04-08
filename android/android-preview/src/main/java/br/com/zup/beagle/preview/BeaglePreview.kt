/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.preview

import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.WebSocket
import okhttp3.WebSocketListener

internal const val PREVIEW_ENDPOINT = "http://10.0.2.2"
internal const val DEFAULT_PORT = "9721"
internal const val CLOSE_CODE = 1001
internal const val CLOSE_REASON = "onDestroy"

class BeaglePreview(host: String? = null, private val okHttpClient: OkHttpClient = OkHttpClient()) {

    private val request: Request = Request
        .Builder()
        .url("${host ?: PREVIEW_ENDPOINT}:$DEFAULT_PORT")
        .build()
    private lateinit var webSocket: WebSocket

    fun start(webSocketListener: WebSocketListener) {
        webSocket = okHttpClient.newWebSocket(request, webSocketListener)
    }

    fun close() {
        webSocket.close(code = CLOSE_CODE, reason = CLOSE_REASON)
    }
}
