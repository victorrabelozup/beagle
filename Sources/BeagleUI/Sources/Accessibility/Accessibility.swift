//
//  Copyright © 11/02/20 Zup IT. All rights reserved.
//

import UIKit

public protocol AccessibilityConfiguratorProtocol {
    func applyAccessibilityAttributes(_ accessibility: Accessibility?, to view: UIView)
}

public protocol DependencyAccessibilityConfigurator {
    var accessibility: AccessibilityConfiguratorProtocol { get }
}

public struct Accessibility {
    /// The value of the accessibility element, in a localized string.
    //public var accessibilityValue: String?
    
    /// A succinct label that identifies the accessibility element, in a localized string.
    public var accessibilityLabel: String?
    
    /// A Boolean value indicating whether VoiceOver should group together the elements that are children of the receiver, regardless of their positions on the screen.
    //public var shouldGroupAccessibilityChildren: Bool
    
    /// A Boolean value indicating whether the receiver is an accessibility element that an assistive application can access
    public var accessible: Bool
    
    /// A mask that contains the OR combination of the accessibility traits that best characterize an accessibility element.
    //var accessibilityTraits: UIAccessibilityTraits = .zero
    // TODO: all the trait options are available in swift4.2+ so we must check if we can update version
    
    /// Initializer for Accessibility
    /// - Parameters:
    ///   - accessibilityLabel: the identifier of the element. Default is nil
    ///   - accessibilityValue: the value of the element. Default is nil
    ///   - shouldGroupAccessibilityChildren: A Boolean value indicating whether VoiceOver should group together the elements that are children of the receiver, regardless of their positions on the screen. Default is false
    ///   - isAccessibilityElement: A Boolean value indicating whether the receiver is an accessibility element that an assistive application can access. Default is true for UIKit elements.
    public init(
        accessibilityLabel: String? = nil,
        accessible: Bool = true
    ) {
        self.accessibilityLabel = accessibilityLabel
        self.accessible = accessible
    }
}

final class AccessibilityConfigurator: AccessibilityConfiguratorProtocol {
    
    public func applyAccessibilityAttributes(_ accessibility: Accessibility?, to view: UIView) {
        guard let accessibility = accessibility else { return }
        if let label = accessibility.accessibilityLabel {
            view.accessibilityLabel = label
        }
        view.isAccessibilityElement = accessibility.accessible
    }
}
