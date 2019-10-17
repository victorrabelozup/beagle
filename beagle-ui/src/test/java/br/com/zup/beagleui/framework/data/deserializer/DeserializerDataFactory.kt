package br.com.zup.beagleui.framework.data.deserializer

fun makeUnitValueJson() = """
    {
        "value": 100.0,
        "type": "PERCENT"
    }
"""

fun makeFlexJson() = """
    {
        "direction": "LTR",
        "flexWrap": "NO_WRAP",
        "justifyContent": "FLEX_START",
        "alignItems": "STRETCH",
        "alignSelf": "AUTO",
        "alignContent": "FLEX_START",
        "basis": ${makeUnitValueJson()},
        "grow": 1.0,
        "shrink": 1
    }
"""

fun makeContainerJson() = """
    {
        "type": "beagle:Container",
        "header": ${makeButtonJson()},
        "content": ${makeVerticalJson()},
        "footer": ${makeButtonJson()}
    }
"""

fun makeFlexWidgetJson() = """
    {
        "type": "beagle:FlexWidget",
        "flex": ${makeFlexJson()},
        "children": [${makeButtonJson()}, ${makeButtonJson()}]
    }
"""

fun makeFlexSingleWidgetJson() = """
    {
        "type": "beagle:FlexSingleWidget",
        "flex": ${makeFlexJson()},
        "child": ${makeVerticalJson()}
    }
"""

fun makeVerticalJson() = """
    {
        "type": "beagle:Vertical",
        "reversed": false,
        "flex": ${makeFlexJson()},
        "children": [${makeButtonJson()}, ${makeButtonJson()}]
    }
"""

fun makeHorizontalJson() = """
    {
        "type": "beagle:Horizontal",
        "reversed": false,
        "flex": ${makeFlexJson()},
        "children": [${makeButtonJson()}, ${makeButtonJson()}]
    }
"""

fun makeStackJson() = """
    {
        "type": "beagle:Stack",
        "flex": ${makeFlexJson()},
        "children": [${makeButtonJson()}, ${makeButtonJson()}]
    }
"""

fun makeSpacerJson() = """
    {
        "type": "beagle:Spacer",
        "size": 30.0
    }
"""

fun makeButtonJson() = """
    {
        "type": "beagle:Button",
        "text": "Test"
    }
"""

fun makeTextJson() = """
    {
        "type": "beagle:Text",
        "text": "Test"
    }
"""

fun makeImageJson() = """
    {
        "type": "beagle:Image",
        "name": "test"
    }
"""

fun makeNetworkImageJson() = """
    {
        "type": "beagle:NetworkImage",
        "url": "http://test.com/test.png"
    }
"""

fun makeListViewJson() = """
    {
        "type": "beagle:ListView",
        "rows": ${makeHorizontalJson()},
        "remoteDataSource": "/dataSource",
        "loadingState": ${makeVerticalJson()}
    }
"""

fun makeTextFieldJson() = """
    {
        "type": "beagle:TextField",
        "hint": "Test",
        "text": "Test"
    }
"""