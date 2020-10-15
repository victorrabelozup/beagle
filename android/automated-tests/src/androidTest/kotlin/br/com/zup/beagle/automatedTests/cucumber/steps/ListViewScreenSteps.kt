/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.com.zup.beagle.automatedTests.cucumber.steps

import android.view.View
import androidx.test.rule.ActivityTestRule
import br.com.zup.beagle.android.utils.toAndroidId
import br.com.zup.beagle.automatedTests.activity.MainActivity
import br.com.zup.beagle.automatedTests.cucumber.elements.*
import br.com.zup.beagle.automatedTests.cucumber.robots.ScreenRobot
import br.com.zup.beagle.automatedTests.utils.ActivityFinisher
import br.com.zup.beagle.automatedTests.utils.TestUtils
import cucumber.api.java.After
import cucumber.api.java.Before
import cucumber.api.java.en.*
import org.junit.Rule

class ListViewScreenSteps {

    @get:Rule
    var activityTestRule = ActivityTestRule(MainActivity::class.java)

    lateinit var listId: String

    @Before("@listview")
    fun setup() {
        TestUtils.startActivity(activityTestRule, Constants.listViewScreenBffUrl)
    }

    @After("@listview")
    fun tearDown() {
        ActivityFinisher.finishOpenActivities()
    }

    @Given("^that I'm on the listView screen with id (.*)$")
    fun checkListViewScreen(listId: String) {
        this.listId = listId
        ScreenRobot()
            .checkViewContainsText(LISTVIEW_SCREEN_HEADER, true)
    }

    @When("^I have a vertical list configured$")
    fun checkVerticalListText() {
        ScreenRobot()
            .checkViewContainsText(STATIC_LISTVIEW_TEXT_1)
            .sleep(2)
    }

    @Then("^listView screen should render all items correctly$")
    fun checkListViewScreenItems() {
        ScreenRobot().checkListSize("list", 20)
    }

    @Then("^listView at (.*) renders view with (.*) and (.*)$")
    fun checkListViewItemRenderText(position: Int, viewId: String, text: String) {
        ScreenRobot()
            .scrollToPosition(listId, position)
            .checkViewContainsTextForId(viewId, text)
    }

    @Then("^listview screen should render all text attributes correctly$")
    fun checkListViewScreenTexts() {
        ScreenRobot()
            .checkViewContainsText(STATIC_LISTVIEW_TEXT_1)
            .checkViewContainsText(STATIC_LISTVIEW_TEXT_2)
            .checkViewContainsText(DYNAMIC_LISTVIEW_TEXT_1)
    }

    @Then("^listview screen should perform the scroll action vertically$")
    fun validateVerticalListScroll() {
        ScreenRobot()
            .scrollTo(DYNAMIC_LISTVIEW_TEXT_2)
            .sleep(2)
    }
//        onView(withId("button:0".toAndroidId())).check(matches(withText("1 OUTSIDE")))
//
//        onView(withId("insideList:19".toAndroidId())).perform(RecyclerViewActions.scrollToPosition<RecyclerView.ViewHolder>(15))
//        onView(withId("buttonInside:15".toAndroidId())).check(matches(withText("Zoe - 15")))

//        onView(withId("button:19".toAndroidId())).perform(click())
//        onView(withId(id.toAndroidId())).perform(RecyclerViewActions.scrollToPosition<RecyclerView.ViewHolder>(0))
//        onView(withId("button:0".toAndroidId())).check(matches(withText("Updated")))


//        onView(isRoot()).perform(orientationLandscape())
//        onView(withId(id.toAndroidId())).check(matches((hasItemCount(expectedSize))))
//        onView(withId("button:0".toAndroidId())).check(matches(withText("Updated")))

}
