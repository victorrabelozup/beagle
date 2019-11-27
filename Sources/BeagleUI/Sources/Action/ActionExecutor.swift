//
//  ActionExecutor.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 21/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

protocol ActionExecutor {
    func doAction(_ action: Action, sender: Any, context: BeagleContext)
}

final class ActionExecuting: ActionExecutor {
    
    private let navigator: BeagleNavigation
    private let customActionHandler: CustomActionHandler?
    
    init(
        navigator: BeagleNavigation = BeagleNavigator(),
        customActionHandler: CustomActionHandler? = BeagleEnvironment.shared.customActionHandler
    ) {
        self.navigator = navigator
        self.customActionHandler = customActionHandler
    }
    
    func doAction(_ action: Action, sender: Any, context: BeagleContext) {
        if let navigation = action as? Navigate {
            navigate(navigation, context: context)
        } else if let formValidation = action as? FormValidation {
            validateForm(formValidation, sender: sender, context: context)
        } else if let nativeDialog = action as? ShowNativeDialog {
            showNativeDialog(nativeDialog, context: context)
        } else if let custom = action as? CustomAction {
            customAction(custom, context: context)
        }
    }
    
    private func navigate(_ action: Navigate, context: BeagleContext) {
        navigator.navigate(action: action, source: context.screenController, animated: true)
    }
    
    private func validateForm(_ action: FormValidation, sender: Any, context: BeagleContext) {
        let inputViews = (sender as? SubmitFormGestureRecognizer)?.formInputViews()
        for error in action.errors {
            let errorListener = inputViews?.first { view in
                (view.beagleFormElement as? FormInput)?.name == error.inputName
            } as? ValidationErrorListener
            errorListener?.onValidationError(message: error.message)
        }
    }
    
    private func showNativeDialog(_ action: ShowNativeDialog, context: BeagleContext) {
        let alert = UIAlertController(title: action.title, message: action.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action.buttonText, style: .default))
        context.screenController.present(alert, animated: true)
    }
    
    private func customAction(_ action: CustomAction, context: BeagleContext) {
        customActionHandler?.handle(context: context, action: action)
    }
}
