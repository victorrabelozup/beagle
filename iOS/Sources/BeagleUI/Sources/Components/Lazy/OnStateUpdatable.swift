//
//  OnStateUpdatable.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 03/12/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

/// Protocol to make an `UIView` present a lazy loaded `Component`.
/// Implementing this protocol the `onUpdateState` method will
/// be called instead of building the component.
public protocol OnStateUpdatable {
    func onUpdateState(component: ServerDrivenComponent) -> Bool
}
