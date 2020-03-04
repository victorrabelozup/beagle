package br.com.zup.beagle.sample.controller

import br.com.zup.beagle.annotation.BeaglePreview
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
    @GetMapping("/sampleAccessibilityScreen")
    fun getAccessibilityView() = this.accessibilityService.createAccessibilityView()

    @BeaglePreview
    @GetMapping("/sample")
    fun getSampleView() = this.sampleViewService.createSampleView()

    @GetMapping("/screenbuilder")
    fun getScreenBuilder() = this.sampleScreenBuilderService.createScreenBuilder()

    @BeaglePreview
    @GetMapping("/sampleComponents")
    fun getSampleComponents() = this.sampleComponentsService.getCreationSampleComponentsView()

    @BeaglePreview
    @GetMapping("/sampleButton")
    fun getSampleButtonView() = this.sampleButtonService.creationButtonView()

    @BeaglePreview
    @GetMapping("/sampleText")
    fun getSampleTextView() = this.sampleTextService.creationTextView()

    @BeaglePreview
    @GetMapping("/sampleImage")
    fun getSampleImageView() = this.sampleImageService.creationImageView()

    @BeaglePreview
    @GetMapping("/sampleTabView")
    fun getSampleTabViewView() = this.sampleTabViewService.creationTabView()

    @BeaglePreview
    @GetMapping("/listview")
    fun getSampleListView() = sampleListViewService.creationListView()

    @BeaglePreview
    @GetMapping("/scrollview")
    fun getScrollView() = sampleScrollViewService.creationScrollView()

    @BeaglePreview
    @GetMapping("/pageView")
    fun getPageView() = this.samplePageViewService.creationPageView()

    @BeaglePreview
    @GetMapping("/action")
    fun getShowDialogAction() = this.sampleActionService.creationAction()

    @BeaglePreview
    @GetMapping("/sample/form")
    fun getSampleFormView() = this.sampleFormService.creationFormView()

    @BeaglePreview
    @GetMapping("/lazycomponent")
    fun getSampleLazyComponentConroller() = this.sampleLazyComponentService.creationLazyComponent()

    @BeaglePreview
    @GetMapping("/navigation/bar")
    fun getSampleNavigationBarController() =
        this.sampleNavigationBarService.creationNavigationBarView()

    @GetMapping("/navigationbar")
    fun getSampleNavigationBar() = this.sampleNavigationBarService.navigationBar()

    @GetMapping("/navigationbar/style")
    fun getNavigationBarStyle() = this.sampleNavigationBarService.navigationBarStyle()

    @GetMapping("/navigationbar/item/text")
    fun getNavigationBarText() = this.sampleNavigationBarService.navigationBarWithTextAsItemt()

    @GetMapping("/navigationbar/item/image")
    fun getNavigationBarImage() = this.sampleNavigationBarService.navigationBarWithImageAsItem()

    @GetMapping("/navigationbar/step1")
    fun getSampleNavigationTypeControlller() =
        this.sampleNavigationTypeService.creationNavigationTypeView()

    @GetMapping("/navigationbar/step2")
    fun getNavigationStep2() = this.sampleNavigationTypeService.step2()

    @GetMapping("/present/view")
    fun getNavigationPresentView() = this.sampleNavigationTypeService.presentView()

    @GetMapping("/navigationbar/step3")
    fun getNavigationStep3() = this.sampleNavigationTypeService.step3()

    @BeaglePreview
    @GetMapping("/sampleStackView")
    fun getSampleStackView() = this.sampleStackService.creationStackView()

    @BeaglePreview
    @GetMapping("/sampleComposeComponent")
    fun getComposeComponent() = this.sampleComposeComponentService.creationComposeComponentView()

    @BeaglePreview
    @GetMapping("/sampleNetworkImage")
    fun getSampleNetworkImageView() = this.sampleNetworkImageService.creationNetworkImage()

    @BeaglePreview
    @GetMapping("/sampleTouchable")
    fun getTouchableView() = this.sampleTouchableService.creationTouchableView()

    @BeaglePreview
    @GetMapping("/actionClick")
    fun getSampleActionClickController() = this.sampleActionClickService.creationActionClick()

    @GetMapping("/navigate-example")
    fun getNavigationExample()= this.sampleActionService.getNavigateExample()
}