/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.micronaut.filter

import br.com.zup.beagle.cache.BeagleCacheHandler
import br.com.zup.beagle.cache.RestCacheHandler
import br.com.zup.beagle.constants.BEAGLE_CACHE_ENABLED
import br.com.zup.beagle.constants.BEAGLE_CACHE_INCLUDES
import io.micronaut.context.annotation.Requirements
import io.micronaut.context.annotation.Requires
import io.micronaut.http.HttpRequest
import io.micronaut.http.HttpResponseFactory
import io.micronaut.http.MutableHttpResponse
import io.micronaut.http.annotation.Filter
import io.micronaut.http.filter.HttpServerFilter
import io.micronaut.http.filter.ServerFilterChain
import io.reactivex.Flowable
import org.reactivestreams.Publisher

@Filter("\${$BEAGLE_CACHE_INCLUDES:/**}")
@Requirements(
    Requires(classes = [BeagleCacheHandler::class]),
    Requires(property = BEAGLE_CACHE_ENABLED, value = "true", defaultValue = "true")
)
class BeagleCacheFilter(private val cacheHandler: BeagleCacheHandler) : HttpServerFilter {
    override fun doFilter(request: HttpRequest<*>?, chain: ServerFilterChain?) =
        this.cacheHandler.handleCache(
            endpoint = request?.path ?: "",
            receivedHash = request?.headers?.get(BeagleCacheHandler.CACHE_HEADER),
            initialResponse = Publisher {
                it.onNext(HttpResponseFactory.INSTANCE.ok<Unit>())
                it.onComplete()
            },
            restHandler = object : RestCacheHandler<Publisher<MutableHttpResponse<*>>?> {
                override fun callController(response: Publisher<MutableHttpResponse<*>>?) = chain?.proceed(request)

                override fun addHashHeader(response: Publisher<MutableHttpResponse<*>>?, header: String) =
                    response?.map { it.header(BeagleCacheHandler.CACHE_HEADER, header) }

                override fun addStatus(response: Publisher<MutableHttpResponse<*>>?, status: Int) =
                    response?.map { it.status(status) }

                override fun getBody(response: Publisher<MutableHttpResponse<*>>?) =
                    Flowable.fromPublisher(response).blockingFirst().body.toString()
            }
        )

    private fun Publisher<MutableHttpResponse<*>>.map(transform: (MutableHttpResponse<*>) -> MutableHttpResponse<*>) =
        Flowable.fromPublisher(this).map(transform)
}