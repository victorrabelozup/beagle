/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer.ui

import android.content.Context
import android.graphics.Bitmap
import android.net.http.SslError
import android.webkit.SslErrorHandler
import android.webkit.WebResourceError
import android.webkit.WebResourceRequest
import android.webkit.WebViewClient
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.UIViewRenderer
import br.com.zup.beagle.view.BeagleActivity
import br.com.zup.beagle.view.ServerDrivenState
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.ui.WebView

internal class WebViewRenderer(
    override val component: WebView,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer<WebView>() {

    override fun buildView(rootView: RootView) = viewFactory.makeWebView(rootView.getContext()).apply {
        webViewClient = BeagleWebViewClient(rootView.getContext())
        loadUrl(component.url)
    }

    class BeagleWebViewClient(val context: Context): WebViewClient() {

        override fun onPageFinished(view: android.webkit.WebView?, url: String?) {
            notify(loading = false)
        }

        override fun onPageStarted(
            view: android.webkit.WebView?,
            url: String?,
            favicon: Bitmap?
        ) {
            notify(loading = true)
        }

        override fun onReceivedSslError(
            view: android.webkit.WebView?,
            handler: SslErrorHandler?,
            error: SslError?
        ) {
            handler?.proceed()
        }

        override fun onReceivedError(
            view: android.webkit.WebView?,
            request: WebResourceRequest?,
            error: WebResourceError?
        ) {
            super.onReceivedError(view, request, error)
            val throwable = Error("$error")
            notify(state = ServerDrivenState.Error(throwable))
        }

        fun notify(loading: Boolean) {
            notify(state = ServerDrivenState.Loading(loading))
        }

        fun notify(state: ServerDrivenState) {
            (context as? BeagleActivity)?.onServerDrivenContainerStateChanged(state)
        }
    }
}
