/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.spring.filter

import br.com.zup.beagle.cache.BeagleCacheHandler
import br.com.zup.beagle.cache.RestCacheHandler
import org.springframework.web.util.ContentCachingResponseWrapper
import javax.servlet.Filter
import javax.servlet.FilterChain
import javax.servlet.ServletRequest
import javax.servlet.ServletResponse
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class BeagleCacheFilter(private val cacheHandler: BeagleCacheHandler) : Filter {
    override fun doFilter(request: ServletRequest, response: ServletResponse, chain: FilterChain) {
        val currentRequest = request as HttpServletRequest

        this.cacheHandler.handleCache(
            endpoint = currentRequest.requestURI,
            receivedHash = currentRequest.getHeader(BeagleCacheHandler.CACHE_HEADER),
            initialResponse = ContentCachingResponseWrapper(response as HttpServletResponse),
            restHandler = object : RestCacheHandler<ContentCachingResponseWrapper> {
                override fun callController(response: ContentCachingResponseWrapper) =
                    response.also { chain.doFilter(request, it) }

                override fun addHashHeader(response: ContentCachingResponseWrapper, header: String) =
                    response.also { it.setHeader(BeagleCacheHandler.CACHE_HEADER, header) }

                override fun addStatus(response: ContentCachingResponseWrapper, status: Int) =
                    response.also { it.status = status }

                override fun getBody(response: ContentCachingResponseWrapper) = String(response.contentAsByteArray)
            }
        ).copyBodyToResponse()
    }
}