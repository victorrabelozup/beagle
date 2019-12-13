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
        val path = "http://example.com/api/"
        val endpoint = "foo/bar/"

        // Then
        assertEquals("http://example.com/api/foo/bar/", urlFormatter.format(path, endpoint))
    }

    @Test
    fun format_no_trailing_slash_should_be_ignored() {
        // Given
        val path = "http://example.com/api"
        val endpoint = "foo/bar/"

        // Then
        assertEquals("http://example.com/foo/bar/", urlFormatter.format(path, endpoint))
    }

    @Test
    fun format_should_retain_host() {
        // Given
        val path = "http://example.com/"
        val endpoint = "/foo/bar/"

        // Then
        assertEquals("http://example.com/foo/bar/", urlFormatter.format(path, endpoint))
    }

    @Test
    fun format_should_retain_host_without_specified_path() {
        // Given
        val path = "http://example.com/api/"
        val endpoint = "/foo/bar/"

        // Then
        assertEquals("http://example.com/foo/bar/", urlFormatter.format(path, endpoint))
    }

    @Test
    fun format_should_replace_all() {
        // Given
        val path = "http://example.com/"
        val endpoint = "https://github.com/square/retrofit/"

        // Then
        assertEquals("https://github.com/square/retrofit/", urlFormatter.format(path, endpoint))
    }

    @Test
    fun format_should_replace_scheme() {
        // Given
        val path = "http://example.com/"
        val endpoint = "//github.com/square/retrofit/"

        // Then
        assertEquals("http://github.com/square/retrofit/", urlFormatter.format(path, endpoint))
    }
}