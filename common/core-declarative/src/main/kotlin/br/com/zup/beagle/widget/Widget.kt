/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.widget

import br.com.zup.beagle.core.Accessibility
import br.com.zup.beagle.core.AccessibilityComponent
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.core.AppearanceComponent
import br.com.zup.beagle.core.FlexComponent
import br.com.zup.beagle.core.IdentifierComponent
import br.com.zup.beagle.widget.core.Flex

abstract class Widget : FlexComponent, AppearanceComponent, AccessibilityComponent,
    IdentifierComponent {

    final override var id: String? = null
        private set
    final override var flex: Flex? = null
        private set
    final override var appearance: Appearance? = null
        private set
    final override var accessibility: Accessibility? = null
        private set

    open fun setId(id: String): Widget {
        this.id = id
        return this
    }

    open fun applyFlex(flex: Flex): Widget {
        this.flex = flex
        return this
    }

    open fun applyAppearance(appearance: Appearance): Widget {
        this.appearance = appearance
        return this
    }

    open fun applyAccessibility(accessibility: Accessibility): Widget {
        this.accessibility = accessibility
        return this
    }
}