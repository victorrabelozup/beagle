package br.com.zup.beagle.networking

import br.com.zup.beagle.testutil.RandomData
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test
import java.net.MalformedURLException
import kotlin.test.assertFails

class UrlFormatterTest {

    private lateinit var urlFormatter: UrlFormatter

    @Before
    fun setUp() {
        urlFormatter = UrlFormatter()
    }

    @Test
    fun format_should_remove_extra_slash_from_start_of_path() {
        // Given
        val endpoint = RandomData.httpUrl() + "/"
        val path = "/foo/bar/"

        // When
        val actual = urlFormatter.format(endpoint, path)

        // Then
        val expected = endpoint + "foo/bar/"
        assertEquals(expected, actual)
    }

    @Test
    fun format_should_add_missing_slash() {
        // Given
        val endpoint = RandomData.httpUrl()
        val path = "foo/bar/"

        // When
        val actual = urlFormatter.format(endpoint, path)

        // Then
        val expected = "$endpoint/foo/bar/"
        assertEquals(expected, actual)
    }

    @Test
    fun format_should_just_concat_endpoint_and_path() {
        // Given
        val endpoint = RandomData.httpUrl() + "/"
        val path = "foo/bar/"

        // When
        val actual = urlFormatter.format(endpoint, path)

        // Then
        val expected = "$endpoint$path"
        assertEquals(expected, actual)
    }

    @Test
    fun format_should_just_concat_endpoint_with_port_and_path() {
        // Given
        val endpoint = RandomData.httpUrl() + ":8080/"
        val path = "foo/bar/"

        // When
        val actual = urlFormatter.format(endpoint, path)

        // Then
        val expected = "$endpoint$path"
        assertEquals(expected, actual)
    }

    @Test
    fun format_should_return_path_as_valid_url() {
        // Given
        val endpoint = RandomData.httpUrl()
        val path = "${RandomData.httpUrl()}/foo/bar/"

        // When
        val actual = urlFormatter.format(endpoint, path)

        // Then
        assertEquals(path, actual)
    }

    @Test
    fun format_should_thrown_a_MalformedURLException_when_endpoint_is_empty() {
        // Given
        val endpoint = ""
        val path = RandomData.string()

        // When
        val exception = assertFails("Invalid baseUrl: $endpoint") { urlFormatter.format(endpoint, path) }

        // Then
        assertTrue(exception is MalformedURLException)
    }

    @Test
    fun format_should_thrown_a_MalformedURLException_when_endpoint_is_not_a_valid_url() {
        // Given
        val endpoint = "http:/10.0.13/"
        val path = RandomData.string()

        // When
        val exception = assertFails("Invalid baseUrl: $endpoint") { urlFormatter.format(endpoint, path) }

        // Then
        assertTrue(exception is MalformedURLException)
    }

    @Test
    fun format_should_thrown_a_MalformedURLException_when_path_is_a_empty_url() {
        // Given
        val endpoint = RandomData.httpUrl()
        val path = ""

        // When
        val exception = assertFails("Invalid path: $path") { urlFormatter.format(endpoint, path) }

        // Then
        assertTrue(exception is MalformedURLException)
    }
}