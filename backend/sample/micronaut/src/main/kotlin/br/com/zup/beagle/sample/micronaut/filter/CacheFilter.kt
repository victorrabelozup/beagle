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

package br.com.zup.beagle.sample.micronaut.filter

import br.com.zup.beagle.cache.BeagleCacheHandler
import br.com.zup.beagle.cache.RestCacheHandler
import io.micronaut.http.HttpRequest
import io.micronaut.http.HttpResponseFactory
import io.micronaut.http.MutableHttpResponse
import io.micronaut.http.annotation.Filter
import io.micronaut.http.filter.HttpServerFilter
import io.micronaut.http.filter.ServerFilterChain
import io.reactivex.Flowable
import org.reactivestreams.Publisher

@Filter("/**")
class CacheFilter : HttpServerFilter {
    private val cacheHandler = BeagleCacheHandler()

    override fun doFilter(request: HttpRequest<*>?, chain: ServerFilterChain?): Publisher<MutableHttpResponse<*>>? {
        var response: Publisher<MutableHttpResponse<*>>? = Flowable.fromCallable {
            HttpResponseFactory.INSTANCE.ok<Unit>()
        }

        this.cacheHandler.handleCache(
            endpoint = request?.path ?: "",
            receivedHash = request?.headers?.get(BeagleCacheHandler.CACHE_HEADER),
            restHandler = object : RestCacheHandler {
                override fun callController() {
                    response = chain?.proceed(request)
                }

                override fun addHashHeaderToResponse(header: String) {
                    response = response?.map { it.header(BeagleCacheHandler.CACHE_HEADER, header) }
                }

                override fun addStatusToResponse(status: Int) {
                    response = response?.map { it.status(status) }
                }

                override fun getResponseBody() = Flowable.fromPublisher(response).blockingFirst().body.toString()
            }
        )

        return response
    }

    private fun Publisher<MutableHttpResponse<*>>.map(transform: (MutableHttpResponse<*>) -> MutableHttpResponse<*>) =
        Flowable.fromPublisher(this).map(transform)
}