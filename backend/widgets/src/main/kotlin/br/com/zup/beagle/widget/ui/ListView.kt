/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.action.Action
import br.com.zup.beagle.widget.context.Bind
import br.com.zup.beagle.widget.context.ContextComponent
import br.com.zup.beagle.widget.context.ContextData
import br.com.zup.beagle.widget.core.ListDirection
import br.com.zup.beagle.widget.utils.BeagleConstants.DEPRECATED_LIST_VIEW

/**
 * ListView is a Layout component that will define a list of views natively.
 * These views could be any Server Driven Component.
 *
 * @param children define the items on the list view.
 * @param direction define the list direction.
 *
 */
data class ListView(
    @Deprecated(
        message = DEPRECATED_LIST_VIEW,
        replaceWith = ReplaceWith("Use dataSource and template instead children.")
    )
    val children: List<ServerDrivenComponent>? = null,
    val direction: ListDirection = ListDirection.VERTICAL,
    override val context: ContextData? = null,
    val onInit: List<Action>? = null,
    val dataSource: Bind<List<Any>>? = null,
    val template: ServerDrivenComponent? = null,
    val onScrollEnd: List<Action>? = null,
    val scrollThreshold: Int? = null,
    val iteratorName: String = "item",
    val key: String? = null
) : Widget(), ContextComponent {

    @Deprecated(
        message = DEPRECATED_LIST_VIEW,
        replaceWith = ReplaceWith(
            "ListView(direction, context, onInit, dataSource, template, onScrollEnd, scrollThreshold," +
                "iteratorName, key)")
    )
    constructor(
        children: List<ServerDrivenComponent>,
        direction: ListDirection
    ) : this(
        children = children,
        direction = direction,
        context = null
    )

    constructor(
        direction: ListDirection,
        context: ContextData? = null,
        onInit: List<Action>? = null,
        dataSource: Bind<List<Any>>,
        template: ServerDrivenComponent,
        onScrollEnd: List<Action>? = null,
        scrollThreshold: Int? = null,
        iteratorName: String = "item",
        key: String? = null
    ) : this(
        null,
        direction,
        context,
        onInit,
        dataSource,
        template,
        onScrollEnd,
        scrollThreshold,
        iteratorName,
        key
    )

    companion object
}
