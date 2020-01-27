package br.com.zup.beagle.networking

import io.mockk.impl.annotations.MockK
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

class UrlFormatterTest {

    @MockK
    private lateinit var urlFormatter: UrlFormatter

    @Before
    fun setUp() {
        urlFormatter = UrlFormatter()
    }

    @Test
    fun format_trailing_slash_should_ensure_path() {
        // Given
        val endpoint = "http://example.com/api/"
        val path = "foo/bar/"

        // Then
        assertEquals("http://example.com/api/foo/bar/", urlFormatter.format(endpoint, path))
    }

    @Test
    fun format_no_trailing_slash_should_be_ignored() {
        // Given
        val endpoint = "http://example.com/api"
        val path = "foo/bar/"

        // Then
        assertEquals("http://example.com/foo/bar/", urlFormatter.format(endpoint, path))
    }

    @Test
    fun format_should_retain_host() {
        // Given
        val endpoint = "http://example.com/"
        val path = "/foo/bar/"

        // Then
        assertEquals("http://example.com/foo/bar/", urlFormatter.format(endpoint, path))
    }

    @Test
    fun format_should_retain_host_without_specified_path() {
        // Given
        val endpoint = "http://example.com/api/"
        val path = "/foo/bar/"

        // Then
        assertEquals("http://example.com/foo/bar/", urlFormatter.format(endpoint, path))
    }

    @Test
    fun format_should_replace_all() {
        // Given
        val path = "https://github.com/square/retrofit/"
        val endpoint = "http://example.com/"

        // Then
        assertEquals("https://github.com/square/retrofit/", urlFormatter.format(endpoint, path))
    }

    @Test
    fun format_should_replace_scheme() {
        // Given
        val endpoint = "http://example.com/"
        val path = "//github.com/square/retrofit/"

        // Then
        assertEquals("http://github.com/square/retrofit/", urlFormatter.format(endpoint, path))
    }
}