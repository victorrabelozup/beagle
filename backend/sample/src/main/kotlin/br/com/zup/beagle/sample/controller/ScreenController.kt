/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.com.zup.beagle.sample.controller

import br.com.zup.beagle.sample.constants.ACCESSIBILITY_SCREEN_ENDPOINT
import br.com.zup.beagle.sample.constants.NAVIGATION_TYPE_ENDPOINT
import br.com.zup.beagle.sample.constants.REPRESENTATION_NAVIGATION_BAR_ENDPOINT
import br.com.zup.beagle.sample.constants.REPRESENTATION_NAVIGATION_BAR_IMAGE_ENDPOINT
import br.com.zup.beagle.sample.constants.REPRESENTATION_NAVIGATION_BAR_STYLE_ENDPOINT
import br.com.zup.beagle.sample.constants.REPRESENTATION_NAVIGATION_BAR_TEXT_ENDPOINT
import br.com.zup.beagle.sample.constants.REPRESENTATION_NAVIGATION_TYPE_STEP2_ENDPOINT
import br.com.zup.beagle.sample.constants.REPRESENTATION_NAVIGATION_TYPE_STEP3_ENDPOINT
import br.com.zup.beagle.sample.constants.REPRESENTATION_PRESENT_ENDPOINT
import br.com.zup.beagle.sample.constants.SAMPLE_VIEW_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_ACTION_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_ACTION_CLICK_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_BUILDER_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_BUTTON_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_COMPONENTS_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_COMPOSE_COMPONENT_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_EXAMPLE_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_FORM_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_IMAGE_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_LAZY_COMPONENT_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_LIST_VIEW_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_NAVIGATION_BAR_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_NETWORK_IMAGE_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_PAGE_VIEW_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_SCROLL_VIEW_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_STACK_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_TAB_VIEW_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_TEXT_ENDPOINT
import br.com.zup.beagle.sample.constants.SCREEN_TOUCHABLE_ENDPOINT
import br.com.zup.beagle.sample.service.AccessibilityService
import br.com.zup.beagle.sample.service.SampleActionClickService
import br.com.zup.beagle.sample.service.SampleActionService
import br.com.zup.beagle.sample.service.SampleButtonService
import br.com.zup.beagle.sample.service.SampleComponentsService
import br.com.zup.beagle.sample.service.SampleComposeComponentService
import br.com.zup.beagle.sample.service.SampleFormService
import br.com.zup.beagle.sample.service.SampleImageService
import br.com.zup.beagle.sample.service.SampleLazyComponentService
import br.com.zup.beagle.sample.service.SampleListViewService
import br.com.zup.beagle.sample.service.SampleNavigationBarService
import br.com.zup.beagle.sample.service.SampleNavigationTypeService
import br.com.zup.beagle.sample.service.SampleNetworkImageService
import br.com.zup.beagle.sample.service.SamplePageViewService
import br.com.zup.beagle.sample.service.SampleScreenBuilderService
import br.com.zup.beagle.sample.service.SampleScrollViewService
import br.com.zup.beagle.sample.service.SampleStackService
import br.com.zup.beagle.sample.service.SampleTabViewService
import br.com.zup.beagle.sample.service.SampleTextService
import br.com.zup.beagle.sample.service.SampleTouchableService
import br.com.zup.beagle.sample.service.SampleViewService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class ScreenController(
    private val accessibilityService: AccessibilityService,
    private val sampleViewService: SampleViewService,
    private val sampleScreenBuilderService: SampleScreenBuilderService,
    private val sampleComponentsService: SampleComponentsService,
    private val sampleButtonService: SampleButtonService,
    private val sampleTextService: SampleTextService,
    private val sampleImageService: SampleImageService,
    private val sampleTabViewService: SampleTabViewService,
    private val sampleListViewService: SampleListViewService,
    private val sampleScrollViewService: SampleScrollViewService,
    private val samplePageViewService: SamplePageViewService,
    private val sampleActionService: SampleActionService,
    private val sampleFormService: SampleFormService,
    private val sampleLazyComponentService: SampleLazyComponentService,
    private val sampleNavigationBarService: SampleNavigationBarService,
    private val sampleNavigationTypeService: SampleNavigationTypeService,
    private val sampleStackService: SampleStackService,
    private val sampleComposeComponentService: SampleComposeComponentService,
    private val sampleNetworkImageService: SampleNetworkImageService,
    private val sampleTouchableService: SampleTouchableService,
    private val sampleActionClickService: SampleActionClickService
) {
    @GetMapping(ACCESSIBILITY_SCREEN_ENDPOINT)
    fun getAccessibilityView() = this.accessibilityService.createAccessibilityView()

    @GetMapping(SAMPLE_VIEW_ENDPOINT)
    fun getSampleView() = this.sampleViewService.createSampleView()

    @GetMapping(SCREEN_BUILDER_ENDPOINT)
    fun getScreenBuilder() = this.sampleScreenBuilderService.createScreenBuilder()

    @GetMapping(SCREEN_COMPONENTS_ENDPOINT)
    fun getSampleComponents() = this.sampleComponentsService.getCreateSampleComponentsView()

    @GetMapping(SCREEN_BUTTON_ENDPOINT)
    fun getSampleButtonView() = this.sampleButtonService.createButtonView()

    @GetMapping(SCREEN_TEXT_ENDPOINT )
    fun getSampleTextView() = this.sampleTextService.createTextView()

    @GetMapping(SCREEN_IMAGE_ENDPOINT)
    fun getSampleImageView() = this.sampleImageService.createImageView()

    @GetMapping(SCREEN_TAB_VIEW_ENDPOINT)
    fun getSampleTabViewView() = this.sampleTabViewService.createTabView()

    @GetMapping(SCREEN_LIST_VIEW_ENDPOINT)
    fun getSampleListView() = sampleListViewService.createListView()

    @GetMapping(SCREEN_SCROLL_VIEW_ENDPOINT)
    fun getScrollView() = sampleScrollViewService.createScrollView()

    @GetMapping(SCREEN_PAGE_VIEW_ENDPOINT)
    fun getPageView() = this.samplePageViewService.createPageView()

    @GetMapping(SCREEN_ACTION_ENDPOINT)
    fun getShowDialogAction() = this.sampleActionService.createAction()

    @GetMapping( SCREEN_FORM_ENDPOINT)
    fun getSampleFormView() = this.sampleFormService.createFormView()

    @GetMapping(SCREEN_LAZY_COMPONENT_ENDPOINT )
    fun getSampleLazyComponentConroller() = this.sampleLazyComponentService.createLazyComponent()

    @GetMapping(SCREEN_NAVIGATION_BAR_ENDPOINT)
    fun getSampleNavigationBarController() =
        this.sampleNavigationBarService.createNavigationBarView()

    @GetMapping(REPRESENTATION_NAVIGATION_BAR_ENDPOINT)
    fun getSampleNavigationBar() = this.sampleNavigationBarService.navigationBar()

    @GetMapping(REPRESENTATION_NAVIGATION_BAR_STYLE_ENDPOINT)
    fun getNavigationBarStyle() = this.sampleNavigationBarService.navigationBarStyle()

    @GetMapping(REPRESENTATION_NAVIGATION_BAR_TEXT_ENDPOINT)
    fun getNavigationBarText() = this.sampleNavigationBarService.navigationBarWithTextAsItemt()

    @GetMapping(REPRESENTATION_NAVIGATION_BAR_IMAGE_ENDPOINT)
    fun getNavigationBarImage() = this.sampleNavigationBarService.navigationBarWithImageAsItem()

    @GetMapping(NAVIGATION_TYPE_ENDPOINT)
    fun getSampleNavigationTypeControlller() =
        this.sampleNavigationTypeService.createNavigationTypeView()

    @GetMapping(REPRESENTATION_NAVIGATION_TYPE_STEP2_ENDPOINT)
    fun getNavigationStep2() = this.sampleNavigationTypeService.step2()

    @GetMapping(REPRESENTATION_PRESENT_ENDPOINT)
    fun getNavigationPresentView() = this.sampleNavigationTypeService.presentView()

    @GetMapping(REPRESENTATION_NAVIGATION_TYPE_STEP3_ENDPOINT)
    fun getNavigationStep3() = this.sampleNavigationTypeService.step3()

    @GetMapping(SCREEN_STACK_ENDPOINT )
    fun getSampleStackView() = this.sampleStackService.createStackView()

    @GetMapping(SCREEN_COMPOSE_COMPONENT_ENDPOINT)
    fun getComposeComponent() = this.sampleComposeComponentService.createComposeComponentView()

    @GetMapping(SCREEN_NETWORK_IMAGE_ENDPOINT)
    fun getSampleNetworkImageView() = this.sampleNetworkImageService.createNetworkImage()

    @GetMapping(SCREEN_TOUCHABLE_ENDPOINT)
    fun getTouchableView() = this.sampleTouchableService.createTouchableView()

    @GetMapping(SCREEN_ACTION_CLICK_ENDPOINT)
    fun getSampleActionClickController() = this.sampleActionClickService.createActionClick()

    @GetMapping(SCREEN_EXAMPLE_ENDPOINT)
    fun getNavigationExample()= this.sampleActionService.getNavigateExample()
}