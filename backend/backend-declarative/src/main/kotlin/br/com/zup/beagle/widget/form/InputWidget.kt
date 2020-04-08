/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.widget.form

import br.com.zup.beagle.core.Accessibility
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.Flex

abstract class InputWidget : Widget() {

    override fun setId(id: String): InputWidget {
        return super.setId(id) as InputWidget
    }

    override fun applyAppearance(appearance: Appearance): InputWidget {
        return super.applyAppearance(appearance) as InputWidget
    }

    override fun applyFlex(flex: Flex): InputWidget {
        return super.applyFlex(flex) as InputWidget
    }

    override fun applyAccessibility(accessibility: Accessibility): InputWidget {
        return super.applyAccessibility(accessibility) as InputWidget
    }
}