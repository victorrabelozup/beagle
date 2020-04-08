/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.ext

import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue

fun Int.unitReal() = UnitValue(this.toDouble(), UnitType.REAL)
fun Int.unitPercent() = UnitValue(this.toDouble(), UnitType.PERCENT)

fun Double.unitReal() = UnitValue(this, UnitType.REAL)
fun Double.unitPercent() = UnitValue(this, UnitType.PERCENT)