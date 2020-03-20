/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.com.zup.beagle.networking

import androidx.core.util.PatternsCompat
import java.net.MalformedURLException

internal class UrlFormatter {

    fun format(endpoint: String, path: String): String {
        // if path has a host, return it as uri
        if (isValidUrl(path)) {
            return path
        }

        if (endpoint.isEmpty() || !isValidUrl(endpoint)) {
            throw MalformedURLException("Invalid baseUrl: $endpoint")
        }

        if (path.isEmpty()) {
            throw MalformedURLException("Invalid path: $path")
        }

        return "$endpoint/$path".replace(Regex("(?<=[^:\\s])(\\/+\\/)"), "/")
    }

    private fun isValidUrl(value: String): Boolean =
        PatternsCompat.WEB_URL.matcher(value).matches()
}