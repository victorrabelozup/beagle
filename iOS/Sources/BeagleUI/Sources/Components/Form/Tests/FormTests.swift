//
// Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import XCTest
import SnapshotTesting
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
    
    func test_whenDecodingJson_thenItShouldReturnAForm() throws {
        let component: Form = try componentFromJsonFile(fileName: "formComponent")
        assertSnapshot(matching: component, as: .dump)
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
