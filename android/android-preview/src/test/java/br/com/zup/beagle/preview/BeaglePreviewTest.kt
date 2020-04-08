/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.preview

import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.slot
import io.mockk.verify
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.WebSocket
import okhttp3.WebSocketListener
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

class BeaglePreviewTest {

    @RelaxedMockK
    private lateinit var okHttpClient: OkHttpClient
    @RelaxedMockK
    private lateinit var webSocket: WebSocket
    @MockK
    private lateinit var webSocketListener: WebSocketListener

    private val requestSlot = slot<Request>()

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        every { okHttpClient.newWebSocket(capture(requestSlot), any()) } returns webSocket
    }

    @Test
    fun beaglePreview_should_use_host_parameter_with_default_port() {
        //GIVEN
        val host = "http://host"
        val subject = BeaglePreview(host, okHttpClient)

        //WHEN
        subject.start(webSocketListener)

        //THEN
        assertEquals("$host:$DEFAULT_PORT/", requestSlot.captured.url.toString())
        verify(exactly = 1) { okHttpClient.newWebSocket(requestSlot.captured, webSocketListener) }
    }

    @Test
    fun beaglePreview_should_use_default_parameter_with_default_port() {
        //GIVEN
        val subject = BeaglePreview(okHttpClient = okHttpClient)

        //WHEN
        subject.start(webSocketListener)

        //THEN
        assertEquals("$PREVIEW_ENDPOINT:$DEFAULT_PORT/", requestSlot.captured.url.toString())
    }

    @Test
    fun start_should_create_webSocket() {
        //GIVEN
        val subject = BeaglePreview(okHttpClient = okHttpClient)

        //WHEN
        subject.start(webSocketListener)

        //THEN
        verify(exactly = 1) { okHttpClient.newWebSocket(requestSlot.captured, webSocketListener) }
    }

    @Test
    fun close_should_use_code_and_reason_default() {
        //GIVEN
        val subject = BeaglePreview(okHttpClient = okHttpClient)

        //WHEN
        subject.start(webSocketListener)
        subject.close()

        //THEN
        verify(exactly = 1) { webSocket.close(code = CLOSE_CODE, reason = CLOSE_REASON) }
    }

    @Test
    fun close_should_close_webSocket() {
        //GIVEN
        val subject = BeaglePreview(okHttpClient = okHttpClient)
        val closeCodeSlot = slot<Int>()
        val closeReasonSlot = slot<String>()
        every { webSocket.close(capture(closeCodeSlot), capture(closeReasonSlot)) } returns true

        //WHEN
        subject.start(webSocketListener)
        subject.close()

        //THEN
        assertEquals(CLOSE_CODE, closeCodeSlot.captured)
        assertEquals(CLOSE_REASON, closeReasonSlot.captured)
    }
}
