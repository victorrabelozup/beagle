//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

/// Defines a container that holds a listview item
final class ListItemCollectionViewCell: UICollectionViewCell {

    /// Sets up with the ComponentView
    /// - Parameter componentView: some componentView
    func setup(with componentView: UIView) {
        componentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        componentView.frame = contentView.bounds
        contentView.addSubview(componentView)
    }
    
}
