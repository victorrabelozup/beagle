//
//  Copyright © 2020 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct FormScreen: DeeplinkScreen {
    
    static var textValidatorName: String { return "text-is-not-blank" }
    static var textValidator: (Any) -> Bool {
        return {
            let trimmed = ($0 as? String)?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
            return !trimmed.isEmpty
        }
    }
    
    init() {}
    
    init(path: String, data: [String : String]?) {}
    
    func screenController() -> UIViewController {
        let flexHorizontalMargin = Flex(margin: Flex.EdgeValue(all: UnitValue(value: 10, type: .real)))
        let form = Form(
            path: "https://us-central1-t001-2751a.cloudfunctions.net/formTest",
            method: .post,
            child: Container(
                children: [
                    FormInput(
                        name: "optional-field",
                        child: DemoTextField(
                            id: nil,
                            placeholder: "Optional field",
                            appearance: nil,
                            flex: flexHorizontalMargin,
                            accessibility: nil
                        )
                    ),
                    FormInput(
                        name: "required-field",
                        required: true,
                        validator: FormScreen.textValidatorName,
                        child: DemoTextField(
                            id: nil,
                            placeholder: "Required field",
                            appearance: nil,
                            flex: flexHorizontalMargin,
                            accessibility: nil
                        )
                    ),
                    FormInput(
                        name: "another-required-field",
                        required: true,
                        validator: FormScreen.textValidatorName,
                        child: DemoTextField(
                            id: nil,
                            placeholder: "Another required field",
                            appearance: nil,
                            flex: flexHorizontalMargin,
                            accessibility: nil
                        )
                    ),
                    Container(children: [], flex: Flex(grow: 1)),
                    FormSubmit(
                        child: Button(text: "Submit Form", style: "DesignSystem.Form.Submit", flex: flexHorizontalMargin),
                        enabled: false
                    )
                ],
                flex: Flex(grow: 1, padding: Flex.EdgeValue(all: UnitValue(value: 20, type: .real))),
                appearance: Appearance(backgroundColor: "#B8E297")
            )
        )
        let screen = Screen(
            navigationBar: NavigationBar(title: "Form"),
            content: form
        )
        return BeagleScreenViewController(viewModel: .init(screenType: .declarative(screen)))
    }
    
}

struct DemoTextField: Widget {
    var id: String?
    
    
    var placeholder: String
    
    var appearance: Appearance?
    var flex: Flex?
    var accessibility: Accessibility?
    
    func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let textField = View()
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder

        textField.applyAppearance(appearance)
        textField.flex.setupFlex(flex)
        dependencies.accessibility.applyAccessibilityAttributes(accessibility, to: textField)
        return textField
    }
    
    final class View: UITextField, UITextFieldDelegate, InputValue, WidgetStateObservable {
        
        var observable = Observable<WidgetState>(value: WidgetState(value: text))
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            delegate = self
            addTarget(self, action: #selector(textChanged), for: .editingChanged)
        }

        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func getValue() -> Any {
            return text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            endEditing(true)
            return true
        }

        @objc private func textChanged() {
            observable.value.value = text
        }
    }
}

struct DemoTextFieldEntity: WidgetEntity {
    var id: String?
    var placeholder: String
    var flex: FlexEntity?
    var appearance: AppearanceEntity?
    var accessibility: AccessibilityEntity?
    
    func mapToComponent() throws -> ServerDrivenComponent {
        return DemoTextField(
            placeholder: placeholder,
            appearance: try appearance?.mapToUIModel(),
            flex: try flex?.mapToUIModel(),
            accessibility: try accessibility?.mapToUIModel()
        )
    }
}
