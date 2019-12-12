package br.com.zup.beagle.declarative.widget.ui

import org.junit.Test
import kotlin.test.assertNull
import kotlin.test.assertTrue

private val DEFAULT_CHILDREN = listOf(Text(""), Text(""))

internal class ListViewTest {

    @Test
    fun listView_should_have_two_children_and_its_default_values() {
        val listView = ListView(DEFAULT_CHILDREN)

        assertTrue { listView.rows.size == 2 }
        assertTrue { listView.direction == ListDirection.VERTICAL }
        assertNull(listView.remoteDataSource)
        assertNull(listView.loadingState)
    }

    @Test
    fun listView_should_have__direction_VERTICAL() {
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