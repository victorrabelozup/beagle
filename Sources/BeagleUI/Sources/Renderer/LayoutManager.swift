//
//  Copyright © 26/12/19 Zup IT. All rights reserved.
//

import UIKit

final class LayoutManager {

    private unowned var context: BeagleContext
    private let componentView: UIView
    private let safeArea: SafeArea?
    
    private var keyboardHeight = CGFloat(0)
    
    public init(context: BeagleContext, componentView: UIView, safeArea: SafeArea?) {
        self.context = context
        self.componentView = componentView
        self.safeArea = safeArea
        addObservers()
        applyLayout()
    }
    
    deinit {
        removeObservers()
    }
    
    public func applyLayout() {
        let flex = Flex(padding: contentPadding)
        componentView.flex.setup(flex)
        context.applyLayout()
    }
    
    // MARK: - Private
    
    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardChangeNotification(_:)),
            name: NSNotification.Name.UIKeyboardWillChangeFrame,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillHideNotification(_:)),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private var contentInsets: UIEdgeInsets {
        let viewController = context.screenController
        if #available(iOS 11.0, *) {
            return viewController.viewIfLoaded?.safeAreaInsets ?? .zero
        }
        return UIEdgeInsets(
            top: viewController.topLayoutGuide.length,
            left: 0,
            bottom: viewController.bottomLayoutGuide.length,
            right: 0
        )
    }
    
    private var contentPadding: Flex.EdgeValue {
        let defaultValue = true
        let insets = contentInsets
        let left = (safeArea?.leading ?? defaultValue) ? insets.left : 0
        let top = (safeArea?.top ?? defaultValue) ? insets.top : 0
        let right = (safeArea?.trailing ?? defaultValue) ? insets.right : 0
        let bottom = (safeArea?.bottom ?? defaultValue) ? insets.bottom : 0
        return Flex.EdgeValue(
            left: UnitValue(value: Double(left), type: .real),
            top: UnitValue(value: Double(top), type: .real),
            right: UnitValue(value: Double(right), type: .real),
            bottom: UnitValue(value: Double(max(keyboardHeight, bottom)), type: .real)
        )
    }
    
    // MARK: - Keyboard
    
    @objc private func handleKeyboardChangeNotification(_ notification: Notification) {
        guard let view = context.screenController.view else { return }

        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let viewFrame = view.convert(view.bounds, to: nil)
        let keyboardRect = keyboardFrame?.intersection(viewFrame)
        
        let height: CGFloat
        if let keyboardRect = keyboardRect, !keyboardRect.isNull {
            height = max(0, keyboardRect.height)
        } else {
            height = 0
        }
        configureKeyboard(height: height, notification: notification)
    }
    
    @objc private func handleKeyboardWillHideNotification(_ notification: Notification) {
        configureKeyboard(height: 0, notification: notification)
    }
    
    private func configureKeyboard(height: CGFloat, notification: Notification) {
        let curve = (notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue
        let duration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        let options = UIView.AnimationOptions(rawValue: (curve ?? 0) << 16)
        keyboardHeight = height
        
        UIView.animate(
            withDuration: duration ?? 0,
            delay: 0,
            options: options,
            animations: { self.applyLayout() },
            completion: nil
        )
    }
}
