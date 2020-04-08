/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.networking.urlbuilder

import br.com.zup.beagle.networking.urlbuilder.UrlBuilderDefault
import br.com.zup.beagle.testutil.RandomData
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class UrlBuilderDefaultTest {

    private lateinit var urlBuilderDefault: UrlBuilderDefault

    @Before
    fun setUp() {
        urlBuilderDefault = UrlBuilderDefault()
    }

    @Test
    fun format_should_concatenate_relative_path() {
        // Given
        val endpoint = RandomData.httpUrl()
        val path = "/" + RandomData.string()

        // When
        val actual = urlBuilderDefault.format(endpoint, path)

        // Then
        val expected = endpoint + path
        Assert.assertEquals(expected, actual)
    }

    @Test
    fun format_should_return_absolute_path() {
        // Given
        val endpoint = RandomData.httpUrl()
        val path = RandomData.httpUrl()

        // When
        val actual = urlBuilderDefault.format(endpoint, path)

        // Then
        Assert.assertEquals(path, actual)
    }

    @Test
    fun format_should_return_path_that_has_no_slash() {
        // Given
        val endpoint = RandomData.httpUrl()
        val path = RandomData.string()

        // When
        val actual = urlBuilderDefault.format(endpoint, path)

        // Then
        Assert.assertEquals(path, actual)
    }
}