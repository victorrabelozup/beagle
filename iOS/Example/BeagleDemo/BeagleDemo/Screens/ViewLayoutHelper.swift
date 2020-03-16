//
//  ViewCode.swift
//  BeagleDemo
//
//  Created by Luis Gustavo Oliveira Silva on 03/03/20.
//  Copyright © 2020 Zup IT. All rights reserved.
//

import Foundation

protocol ViewLayoutHelper {
    func buildViewHierarchy()
    func setupContraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension ViewLayoutHelper {
    func setupView() {
        buildViewHierarchy()
        setupContraints()
        setupAdditionalConfiguration()
    }
}

