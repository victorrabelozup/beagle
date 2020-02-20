//
//  Copyright © 26/12/19 Zup IT. All rights reserved.
//

import Foundation
import UIKit

class KeyboardManager {

    let bottomConstraint: NSLayoutConstraint
    let view: UIView

    public init(
        bottomConstraint: NSLayoutConstraint,
        view: UIView
    ) {
        assert(
            bottomConstraint.firstItem === view
            || bottomConstraint.secondItem === view
        )

        self.bottomConstraint = bottomConstraint
        self.view = view

        addObservers()
    }

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

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc private func handleKeyboardChangeNotification(_ notification: Notification) {
        let height = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        configureKeyboard(height: height ?? 0, notification: notification)
    }

    @objc private func handleKeyboardWillHideNotification(_ notification: Notification) {
        configureKeyboard(height: 0, notification: notification)
    }

    private func configureKeyboard(height: CGFloat, notification: Notification) {
        let curve = (notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue
        let duration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        let options = UIView.AnimationOptions(rawValue: (curve ?? 0) << 16)
    
        // swiftlint:disable trailing_closure
        UIView.animate(
            withDuration: duration ?? 0,
            delay: 0,
            options: options,
            animations: {
                self.bottomConstraint.constant = height
                self.view.layoutIfNeeded()
            }
        )
    }
}
