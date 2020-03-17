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

class CacheFilter(excludeEndpointList: List<String>) : Filter {
    private val cacheHandler = BeagleCacheHandler(excludeEndpointList)

    override fun doFilter(request: ServletRequest, response: ServletResponse, chain: FilterChain) {
        val currentRequest = request as HttpServletRequest
        val responseWrapper = ContentCachingResponseWrapper(response as HttpServletResponse)

        this.cacheHandler.handleCache(
            endpoint = currentRequest.requestURI,
            receivedHash = currentRequest.getHeader(BeagleCacheHandler.CACHE_HEADER),
            restHandler = object : RestCacheHandler {
                override fun callController() {
                    chain.doFilter(currentRequest, responseWrapper)
                }

                override fun finalizeResponse() {
                    responseWrapper.copyBodyToResponse()
                }

                override fun addHashHeaderToResponse(header: String) {
                    responseWrapper.setHeader(BeagleCacheHandler.CACHE_HEADER, header)
                }

                override fun addStatusToResponse(status: Int) {
                    responseWrapper.status = status
                }

                override fun getResponseBody() = String(responseWrapper.contentAsByteArray)
            }
        )
    }
}