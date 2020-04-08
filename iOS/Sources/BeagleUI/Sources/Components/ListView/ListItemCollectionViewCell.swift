/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
