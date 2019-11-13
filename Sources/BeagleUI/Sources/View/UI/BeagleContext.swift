import UIKit

/// Interface to access application specific operations
public protocol BeagleContext {
    func register(action: Action, inView view: UIView)
}

extension BeagleScreenViewController: BeagleContext {
    
    public func register(action: Action, inView view: UIView) {
        let gestureRecognizer = ActionGestureRecognizer(
            action: action,
            target: self,
            selector: #selector(handleActionGesture(_:)))
        view.addGestureRecognizer(gestureRecognizer)
        view.isUserInteractionEnabled = true
    }
    
    @objc private func handleActionGesture(_ sender: ActionGestureRecognizer) {
        if let action = sender.action as? Navigate {
            BeagleNavigator.navigate(action: action, source: self, animated: true)
        }
    }
}

private class ActionGestureRecognizer: UITapGestureRecognizer {
    
    let action: Action
    
    init(action: Action, target: Any?, selector: Selector?) {
        self.action = action
        super.init(target: target, action: selector)
    }
}
