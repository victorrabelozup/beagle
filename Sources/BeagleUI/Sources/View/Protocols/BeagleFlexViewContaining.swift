//
//  BeagleFlexViewContaining.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 10/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

protocol BeagleFlexViewContaining {
    var beagleView: BeagleFlexView { get }
}
extension BeagleFlexViewContaining where Self: UIViewController {
    var beagleView: BeagleFlexView {
        guard let beagleView = view as? BeagleFlexView else {
            fatalError("The view should be of type `BeagleFlexView`.")
        }
        return beagleView
    }
}
