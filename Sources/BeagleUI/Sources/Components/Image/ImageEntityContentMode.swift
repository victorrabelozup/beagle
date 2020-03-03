//
//  ImageEntityContentMode.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public enum ImageEntityContentMode: String, Codable, UIEnumModelConvertible {
    case fitXY = "FIT_XY" // scaleToFill
    case fitCenter = "FIT_CENTER" // scaleAspectFit
    case centerCrop = "CENTER_CROP" // scaleAspectFill
    case center = "CENTER" // center
}
