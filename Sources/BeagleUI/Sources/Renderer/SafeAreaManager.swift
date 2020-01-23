//
//  Copyright © 21/01/20 Zup IT. All rights reserved.
//

import UIKit

final class SafeAreaManager {
    
    private struct Anchors {
        let top: NSLayoutYAxisAnchor
        let leading: NSLayoutXAxisAnchor
        let bottom: NSLayoutYAxisAnchor
        let trailing: NSLayoutXAxisAnchor
    }
    
    let view: UIView
    
    var safeArea: SafeArea? {
        didSet {
            if safeArea != oldValue {
                applyConstraints()
            }
        }
    }
    
    private let safeAreaAnchors: Anchors
    private var constraints: [NSLayoutConstraint] = []
    
    public init(viewController: UIViewController, view: UIView, safeArea: SafeArea?) {
        if #available(iOS 11.0, *) {
            let guide = viewController.view.safeAreaLayoutGuide
            self.safeAreaAnchors = .init(
                top: guide.topAnchor,
                leading: guide.leadingAnchor,
                bottom: guide.bottomAnchor,
                trailing: guide.trailingAnchor
            )
        } else {
            self.safeAreaAnchors = .init(
                top: viewController.topLayoutGuide.bottomAnchor,
                leading: viewController.view.leadingAnchor,
                bottom: viewController.bottomLayoutGuide.topAnchor,
                trailing: viewController.view.trailingAnchor
            )
        }
        self.view = view
        self.safeArea = safeArea
        applyConstraints()
    }
    
    private func applyConstraints() {
        guard let superview = view.superview else {
            assertionFailure("`view.superview` should not be nil")
            return
        }
        NSLayoutConstraint.deactivate(constraints)
        constraints.removeAll()
        
        let topAnchor = (safeArea?.top ?? false) ? safeAreaAnchors.top : superview.topAnchor
        let leadingAnchor = (safeArea?.leading ?? false) ? safeAreaAnchors.leading : superview.leadingAnchor
        let bottomAnchor = (safeArea?.bottom ?? false) ? safeAreaAnchors.bottom : superview.bottomAnchor
        let trailingAnchor = (safeArea?.trailing ?? false) ? safeAreaAnchors.trailing : superview.trailingAnchor
        
        let bottomConstraint = view.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottomConstraint.priority = .init(999)
        
        constraints.append(bottomConstraint)
        constraints.append(view.topAnchor.constraint(equalTo: topAnchor))
        constraints.append(view.leadingAnchor.constraint(equalTo: leadingAnchor))
        constraints.append(view.trailingAnchor.constraint(equalTo: trailingAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
