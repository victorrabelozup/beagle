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
    
    private(set) var widgetView: UIView?

    // MARK: - Lifecycle

    public override func prepareForReuse() {
        super.prepareForReuse()
        (widgetView as? HTTPRequestCanceling)?.cancelHTTPRequest()
        widgetView?.removeFromSuperview()
        widgetView = nil
    }

    // MARK: - Setup
    
    /// Sets up with the WidgetView
    /// - Parameter widgetView: some widgetView
    func setup(with widgetView: UIView) {
        self.widgetView = widgetView
        widgetView.frame = contentView.frame
        contentView.addSubview(widgetView)
    }
    
}
