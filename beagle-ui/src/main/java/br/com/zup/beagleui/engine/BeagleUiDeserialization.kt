package br.com.zup.beagleui.engine

import br.com.zup.beagleui.engine.framework.core.Widget
import br.com.zup.beagleui.engine.framework.layout.*
import br.com.zup.beagleui.engine.framework.ui.*
import com.google.gson.Gson
import org.json.JSONObject
import com.google.gson.GsonBuilder


class BeagleUiDeserialization {

    fun deserialize(jsonObject: JSONObject): Widget {
        val gson = makeBeagleGson()
        return gson.fromJson(jsonObject.toString(), Widget::class.java)
    }
}