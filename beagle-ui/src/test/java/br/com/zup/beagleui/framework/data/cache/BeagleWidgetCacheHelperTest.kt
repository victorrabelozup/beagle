package br.com.zup.beagleui.framework.data.cache

import br.com.zup.beagleui.framework.testutil.RandomData
import br.com.zup.beagleui.framework.widget.core.Widget
import io.mockk.mockk
import org.junit.Test
import kotlin.test.assertEquals
import kotlin.test.assertNull

class BeagleWidgetCacheHelperTest {

    private val subject = BeagleWidgetCacheHelper()

    private val url = RandomData.httpUrl()

    private val widget = mockk<Widget>(relaxUnitFun = true)

    @Test
    fun test_cache_should_return_get_cached_value() {
        //given
        subject.cacheWidget(url, widget)

        //when
        val result = subject.getWidgetFromCache(url)

        //then
        assertEquals(widget, result)
    }

    @Test
    fun test_cache_should_return_get_no_cached_value() {
        //Given
        val expectedUrl = RandomData.httpUrl()

        //when
        val result = subject.getWidgetFromCache(expectedUrl)

        //then
        assertNull(result)
    }
}