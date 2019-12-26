//
//  Copyright © 22/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FormWidgetViewRendererTests: XCTestCase {

    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let rendererProvider = RendererProviderSpy()
        let dependencies = RendererDependenciesContainer(
            rendererProvider: rendererProvider
        )

        let form = Form(action: "/singup", method: .post, child: WidgetDummy())
        guard let sut = try? FormWidgetViewRenderer(
            widget: form,
            dependencies: dependencies
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
                
        // When
        _ = sut.buildView(context: BeagleContextDummy())
        
        // Then
        XCTAssertEqual(rendererProvider.buildRendererCount, 1)
    }
    
    func test_buildView_shouldRegisterFormSubmit() throws {
        // Given
        let child = FlexWidget(children: [FormSubmit(child: Text("submit"))])
        let form = Form(action: "/singup", method: .post, child: child)
        let dependencies = RendererDependenciesContainer(
            rendererProvider: RendererProviding()
        )

        let renderer = try FormWidgetViewRenderer(widget: form, dependencies: dependencies)
        let context = BeagleContextSpy()
                
        // When
        _ = renderer.buildView(context: context)
        
        // Then
        XCTAssertTrue(context.didCallRegisterFormSubmit)
    }
}

class BeagleContextSpy: BeagleContext {
    
    private(set) var didCallRegisterAction = false
    private(set) var didCallRegisterFormSubmit = false
    private(set) var didCallLazyLoad = false
    private(set) var didCallDoAction = false
    
    var screenController: UIViewController = UIViewController()
    
    func register(action: Action, inView view: UIView) {
        didCallRegisterAction = true
    }
    
    func register(form: Form, formView: UIView, submitView: UIView, validator: ValidatorProvider?) {
        didCallRegisterFormSubmit = true
    }
    
    func lazyLoad(url: String, initialState: UIView) {
        didCallLazyLoad = true
    }
    
    func doAction(_ action: Action, sender: Any) {
        didCallDoAction = true
    }
}
