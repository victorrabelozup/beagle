/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.mapper

import android.widget.ImageView
import br.com.zup.beagle.widget.core.ImageContentMode

class ViewMapper {

    fun toScaleType(contentMode: ImageContentMode) = when (contentMode) {
        ImageContentMode.FIT_XY -> ImageView.ScaleType.FIT_XY
        ImageContentMode.FIT_CENTER -> ImageView.ScaleType.FIT_CENTER
        ImageContentMode.CENTER_CROP -> ImageView.ScaleType.CENTER_CROP
        ImageContentMode.CENTER -> ImageView.ScaleType.CENTER
    }
}
