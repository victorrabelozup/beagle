/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.utils;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class BeagleUtilsTest {

    @Test
    public void toAndroidId_should_return_3546_when_value_is_oi() {
        // Given
        final String myId = "oi";

        // When
        final int result = BeagleUtils.toAndroidId(myId);

        // Then
        assertEquals(3546, result);
    }
}
