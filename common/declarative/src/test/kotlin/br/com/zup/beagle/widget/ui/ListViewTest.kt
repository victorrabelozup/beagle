/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.widget.ui

import org.junit.Test
import kotlin.test.assertTrue

private val DEFAULT_CHILDREN = listOf(Text(""), Text(""))

internal class ListViewTest {

    @Test
    fun listView_should_have_two_children_and_its_default_values() {
        val listView = ListView(DEFAULT_CHILDREN)

        assertTrue { listView.rows.size == 2 }
        assertTrue { listView.direction == ListDirection.VERTICAL }
    }

    @Test
    fun listView_should_have_direction_VERTICAL() {
        val listView = ListView(DEFAULT_CHILDREN, direction = ListDirection.HORIZONTAL)

        assertTrue { listView.direction == ListDirection.HORIZONTAL }
    }

    @Test
    fun listView_dynamic_should_create_two_children_and_direction_VERTICAL() {
        val listView = ListView.dynamic(size = 2) { index ->
            Text(index.toString())
        }

        assertTrue { listView.rows.size == 2 }
        assertTrue { listView.direction == ListDirection.VERTICAL }
    }
}