package br.com.zup.beagle.data.deserializer

import br.com.zup.beagle.testutil.RandomData

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
        "_beagleType_": "beagle:widget:container",
        "header": ${makeButtonJson()},
        "content": ${makeVerticalJson()},
        "footer": ${makeButtonJson()}
    }
"""

fun makeFlexWidgetJson() = """
    {
        "_beagleType_": "beagle:widget:flexwidget",
        "flex": ${makeFlexJson()},
        "children": [${makeButtonJson()}, ${makeButtonJson()}]
    }
"""

fun makeFlexSingleWidgetJson() = """
    {
        "_beagleType_": "beagle:widget:flexsinglewidget",
        "flex": ${makeFlexJson()},
        "child": ${makeVerticalJson()}
    }
"""

fun makeVerticalJson() = """
    {
        "_beagleType_": "beagle:widget:vertical",
        "reversed": false,
        "flex": ${makeFlexJson()},
        "children": [${makeButtonJson()}, ${makeButtonJson()}]
    }
"""

fun makeHorizontalJson() = """
    {
        "_beagleType_": "beagle:widget:horizontal",
        "reversed": false,
        "flex": ${makeFlexJson()},
        "children": [${makeButtonJson()}, ${makeButtonJson()}]
    }
"""

fun makeStackJson() = """
    {
        "_beagleType_": "beagle:widget:stack",
        "flex": ${makeFlexJson()},
        "children": [${makeButtonJson()}, ${makeButtonJson()}]
    }
"""

fun makeSpacerJson() = """
    {
        "_beagleType_": "beagle:widget:spacer",
        "size": 30.0
    }
"""

fun makeButtonJson() = """
    {
        "_beagleType_": "beagle:widget:button",
        "text": "Test"
    }
"""

fun makeTextJson() = """
    {
        "_beagleType_": "beagle:widget:text",
        "text": "Test"
    }
"""

fun makeImageJson() = """
    {
        "_beagleType_": "beagle:widget:image",
        "name": "test"
    }
"""

fun makeNetworkImageJson() = """
    {
        "_beagleType_": "beagle:widget:networkimage",
        "url": "http://test.com/test.png"
    }
"""

fun makeListViewJson() = """
    {
        "_beagleType_": "beagle:widget:listview",
        "rows": [${makeButtonJson()}],
        "remoteDataSource": "/dataSource",
        "loadingState": ${makeVerticalJson()}
    }
"""

fun makeCustomWidgetJson() = """
    {
        "_beagleType_": "sample:widget:customwidget"
    }
"""

fun makeLazyWidgetJson() = """
    {
        "_beagleType_": "beagle:widget:lazywidget",
        "url": "${RandomData.httpUrl()}",
        "initialState": ${makeButtonJson()}
    }
"""

fun makeScrollViewJson() = """
    {
    "_beagleType_": "beagle:widget:scrollview",
    "children": [
        {
            "_beagleType_": "beagle:widget:flexwidget",
            "flex": {
                "flexDirection": "ROW"
            },
            "children": [
                ${makeTextJson()},
                ${makeTextJson()},
                ${makeTextJson()},
                ${makeTextJson()},
                ${makeTextJson()},
                ${makeTextJson()}
            ]
        }
    ],
    "scrollDirection": "HORIZONTAL"
}
"""

fun makePageViewWidgetJson() = """
    {
        "_beagleType_": "beagle:widget:pageview",
        "pages": [
            ${makeButtonJson()},
            ${makeButtonJson()},
            ${makeButtonJson()}
        ]
    }
"""

fun makePageIndicatorWidgetJson() = """
    {
        "_beagleType_": "beagle:widget:pageindicator",
        "selectedColor": "#FFFFFF",
        "unselectedColor": "#888888"
    }
"""

fun makeNavigationActionJson() = """
    {
        "_beagleType_": "beagle:action:navigate",
        "type": "ADD_VIEW",
        "value": {
            "path": "${RandomData.httpUrl()}"
        }
    }
"""

fun makeShowNativeDialogJson() = """
    {
        "_beagleType_": "beagle:action:shownativedialog",
        "title": "${RandomData.string()}",
        "message": "${RandomData.string()}",
        "buttonText": "Ok"
    }
"""

fun makeCustomActionJson() = """
    {
        "_beagleType_": "beagle:action:customaction",
        "name": "${RandomData.string()}",
        "data": {}
    }
"""

fun makeFormValidationJson() = """
    {
        "_beagleType_": "beagle:action:formvalidation",
        "errors": []
    }
"""

fun makeCustomInputWidgetJson() = """
    {
        "_beagleType_": "sample:widget:custominputwidget"
    }
"""

fun makeFormInputJson() = """
    {
        "_beagleType_": "beagle:widget:forminput",
        "name": "${RandomData.string()}",
        "child": ${makeCustomInputWidgetJson()}
    }
"""

fun makeFormSubmitJson() = """
    {
        "_beagleType_": "beagle:widget:formsubmit",
        "child": ${makeButtonJson()}
    }
"""

fun makeFormJson() = """
    {
        "_beagleType_": "beagle:widget:form",
        "action": "${RandomData.string()}",
        "method": "POST",
        "child": ${makeButtonJson()}
    }
"""