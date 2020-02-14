package br.com.zup.beagle.engine.renderer.ui

import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.UIViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.ui.ListDirection
import br.com.zup.beagle.widget.ui.ListView

internal class ListViewRenderer(
    override val component: ListView,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer<ListView>() {

    override fun buildView(rootView: RootView): View {
        return viewFactory.makeRecyclerView(rootView.getContext()).apply {
            val direction = toRecyclerViewOrientation()
            layoutManager = LinearLayoutManager(context, direction, false)
            adapter = ListViewRecyclerAdapter(rootView, component.rows)
        }
    }

    private fun toRecyclerViewOrientation(): Int {
        return if (component.direction == ListDirection.VERTICAL) {
            RecyclerView.VERTICAL
        } else {
            RecyclerView.HORIZONTAL
        }
    }
}

internal class ListViewRecyclerAdapter(
    private val rootView: RootView,
    private val rows: List<ServerDrivenComponent>,
    private val viewRendererFactory: ViewRendererFactory = ViewRendererFactory()
) : RecyclerView.Adapter<ViewHolder>() {

    override fun getItemViewType(position: Int): Int = position

    override fun onCreateViewHolder(parent: ViewGroup, position: Int): ViewHolder {
        val view = viewRendererFactory.make(rows[position]).build(rootView)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {}

    override fun getItemCount(): Int = rows.size
}

internal class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView)