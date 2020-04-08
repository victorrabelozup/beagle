/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.networking.urlbuilder

internal class UrlBuilderDefault : UrlBuilder {

    override fun format(endpoint: String, path: String): String {
        if (isRelativePath(path)) {
            return endpoint + path
        } else {
            return path
        }
    }

    private fun isRelativePath(path: String): Boolean {
        return path.startsWith("/")
    }
}