/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer.ui

import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.UIViewRenderer
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.ui.ListDirection
import br.com.zup.beagle.widget.ui.ListView

internal class ListViewRenderer(
    override val component: ListView,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer<ListView>() {

    override fun buildView(rootView: RootView): View {
        return viewFactory.makeRecyclerView(rootView.getContext()).apply {
            val orientation = toRecyclerViewOrientation()
            layoutManager = LinearLayoutManager(context, orientation, false)
            adapter = ListViewRecyclerAdapter(rootView, component.rows, viewFactory, orientation)
        }
    }

    private fun toRecyclerViewOrientation() = if (component.direction == ListDirection.VERTICAL) {
        RecyclerView.VERTICAL
    } else {
        RecyclerView.HORIZONTAL
    }
}

internal class ListViewRecyclerAdapter(
    private val rootView: RootView,
    private val rows: List<ServerDrivenComponent>,
    private val viewFactory: ViewFactory,
    private val orientation: Int
) : RecyclerView.Adapter<ViewHolder>() {

    override fun getItemViewType(position: Int): Int = position

    override fun onCreateViewHolder(parent: ViewGroup, position: Int): ViewHolder {
        val view = viewFactory.makeBeagleFlexView(rootView.getContext()).also {
            val width = if (orientation == RecyclerView.VERTICAL)
                ViewGroup.LayoutParams.MATCH_PARENT else
                ViewGroup.LayoutParams.WRAP_CONTENT
            val layoutParams = ViewGroup.LayoutParams(width, ViewGroup.LayoutParams.WRAP_CONTENT)
            it.layoutParams = layoutParams
            it.addServerDrivenComponent(rows[position], rootView)
        }
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {

    }

    override fun getItemCount(): Int = rows.size
}

internal class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView)