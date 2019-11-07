package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.ui.ListDirection
import br.com.zup.beagleui.framework.widget.ui.ListView

internal class ListViewRenderer(
    private val widget: ListView,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer {

    override fun build(context: Context): View {
        return viewFactory.makeRecyclerView(context).apply {
            val direction = toRecyclerViewOrientation()
            layoutManager = LinearLayoutManager(context, direction, false)
            adapter = ListViewRecyclerAdapter(widget.rows)
        }
    }

    private fun toRecyclerViewOrientation(): Int {
        return if (widget.direction == ListDirection.VERTICAL) {
            RecyclerView.VERTICAL
        } else {
            RecyclerView.HORIZONTAL
        }
    }
}

internal class ListViewRecyclerAdapter(
    private val rows: List<Widget>,
    private val viewRendererFactory: ViewRendererFactory = ViewRendererFactory()
) : RecyclerView.Adapter<ViewHolder>() {

    override fun getItemViewType(position: Int): Int = position

    override fun onCreateViewHolder(parent: ViewGroup, position: Int): ViewHolder {
        val view = viewRendererFactory.make(rows[position]).build(parent.context)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {}

    override fun getItemCount(): Int = rows.size
}

internal class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView)