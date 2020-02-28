package br.com.zup.beagle.utils

import org.junit.Test

import org.junit.Assert.*

class StringExtensionsKtTest {

    @Test
    fun toAndroidId_should_return_int_representation() {
        // Given
        val myId = "smallId"

        Integer.MAX_VALUE

        // When
        val result = myId.toAndroidId()

        // Then
        assertEquals(result, 710)
    }
}