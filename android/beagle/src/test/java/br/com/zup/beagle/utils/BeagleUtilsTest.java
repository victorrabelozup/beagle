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
