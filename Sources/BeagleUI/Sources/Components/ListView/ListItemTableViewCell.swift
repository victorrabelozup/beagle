//
//  ListItemTableViewCell.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 07/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

/// Defines a container that holds a listview item
final class ListItemCollectionViewCell: UICollectionViewCell {

    // MARK: - Private Properties
    
    private(set) var componentView: UIView?

    // MARK: - Lifecycle

    public override func prepareForReuse() {
        super.prepareForReuse()
        (componentView as? HTTPRequestCanceling)?.cancelHTTPRequest()
        componentView?.removeFromSuperview()
        componentView = nil
    }

    // MARK: - Setup
    
    /// Sets up with the ComponentView
    /// - Parameter componentView: some componentView
    func setup(with componentView: UIView) {
        self.componentView = componentView
        componentView.frame = contentView.frame
        contentView.addSubview(componentView)
    }
    
}
