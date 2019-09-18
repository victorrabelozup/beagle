//
//  StyledView.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct StyledWidget: Widget {
    let border: Border?
    let color: String?
    let child: Widget?
}

public struct Border {
    let color: String?
    let radius: Double?
    let size: Double?
}
