/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.setup

import android.app.Application
import br.com.zup.beagle.action.CustomActionHandler
import br.com.zup.beagle.form.ValidatorHandler
import br.com.zup.beagle.navigation.DeepLinkHandler
import br.com.zup.beagle.networking.HttpClient
import br.com.zup.beagle.networking.urlbuilder.UrlBuilder
import br.com.zup.beagle.view.BeagleActivity
import br.com.zup.beagle.widget.core.WidgetView
import com.facebook.soloader.SoLoader

enum class Environment {
    DEBUG,
    PRODUCTION
}

internal object BeagleEnvironment {
    lateinit var beagleSdk: BeagleSdk
    lateinit var application: Application
}

interface BeagleSdk {
    val config: BeagleConfig
    val customActionHandler: CustomActionHandler?
    val deepLinkHandler: DeepLinkHandler?
    val validatorHandler: ValidatorHandler?
    val httpClient: HttpClient?
    val designSystem: DesignSystem?
    val serverDrivenActivity: Class<BeagleActivity>
    val urlBuilder: UrlBuilder?

    fun registeredWidgets(): List<Class<WidgetView>>

    fun init(application: Application) {
        BeagleEnvironment.beagleSdk = this
        BeagleEnvironment.application = application
        SoLoader.init(application, false)
    }
}

interface BeagleConfig {
    val environment: Environment
    val baseUrl: String
}
