//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FormTests: XCTestCase {
    
    func test_initWithChild_shouldReturnValidForm() {
        // Given / When
        let sut = Form(path: "path", method: .get, child:
            Text("Teste")
        )
        // Then
        XCTAssertTrue(sut.child is Text)
    }
    
    func test_buildView_shouldRegisterFormSubmit() throws {
        // Given
        let child = Container(children: [FormSubmit(child: Text("submit"))])
        let form = Form(path: "/singup", method: .post, child: child)
        let context = BeagleContextSpy()
                
        // When
        _ = form.toView(context: context, dependencies: BeagleScreenDependencies())
        
        // Then
        XCTAssertTrue(context.didCallRegisterFormSubmit)
    }
}

class BeagleContextSpy: BeagleContext {
    
    private(set) var didCallRegisterAction = false
    private(set) var didCallRegisterFormSubmit = false
    private(set) var didCallLazyLoad = false
    private(set) var didCallDoAction = false
    private(set) var didCallRegisterEnabledWidget = false
    private(set) var actionCalled: Action?
    private(set) var didCallApplyLayout = true
    
    var screenController: UIViewController = UIViewController()
    
    func register(action: Action, inView view: UIView) {
        didCallRegisterAction = true
    }
    
    func register(formSubmitEnabledWidget: Widget?, formSubmitDisabledWidget: Widget?) {
        didCallRegisterEnabledWidget = true
    }
    
    func register(form: Form, formView: UIView, submitView: UIView, validatorHandler validator: ValidatorProvider?) {
        didCallRegisterFormSubmit = true
    }
    
    func lazyLoad(url: String, initialState: UIView) {
        didCallLazyLoad = true
    }
    
    func doAction(_ action: Action, sender: Any) {
        didCallDoAction = true
        actionCalled = action
    }
    
    func applyLayout() {
        didCallApplyLayout = true
    }
}
