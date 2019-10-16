//
//  FlexViewConfigurator.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 09/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation
import YogaKit

public protocol FlexViewConfiguratorProtocol {
    func applyFlex(_ flex: Flex, to view: UIView)
}

final class FlexViewConfigurator: FlexViewConfiguratorProtocol {
    
    // MARK: - Dependencies
    
    let yogaTranslator: YogaTranslator
    
    // MARK: - Initialization
    
    init(yogaTranslator: YogaTranslator = YogaTranslating()) {
        self.yogaTranslator = yogaTranslator
    }
    
    // MARK: - Public Methods
    
    func applyFlex(_ flex: Flex, to view: UIView) {
        view.yoga.isEnabled = true
        applyYogaProperties(from: flex, to: view.yoga)
        applyAtributes(from: flex, to: view.yoga)
        view.yoga.applyLayout(preservingOrigin: true)
    }
    
    // MARK: - Private Methods
    
    private func applyYogaProperties(from flex: Flex, to layout: YGLayout) {
        layout.flexDirection = yogaTranslator.translate(flex.flexDirection)
        layout.direction = yogaTranslator.translate(flex.direction)
        layout.flexWrap = yogaTranslator.translate(flex.flexWrap)
        layout.justifyContent = yogaTranslator.translate(flex.justifyContent)
        layout.alignItems = yogaTranslator.translate(flex.alignItems)
        layout.alignSelf = yogaTranslator.translate(flex.alignItems)
        layout.alignContent = yogaTranslator.translate(flex.alignContent)
        layout.flexGrow = CGFloat(flex.grow)
        layout.flexShrink = CGFloat(flex.shrink)
        layout.display = yogaTranslator.translate(flex.display)
    }
    
    private func applyAtributes(from flex: Flex, to layout: YGLayout) {
        setWidth(flex.size.width, to: layout)
        setHeight(flex.size.height, to: layout)
        setMaxWidth(flex.size.maxWidth, to: layout)
        setMaxHeight(flex.size.maxHeight, to: layout)
        setMinWidth(flex.size.minWidth, to: layout)
        setMinHeight(flex.size.minHeight, to: layout)
        setBasis(flex.basis, to: layout)
        setAspectRatio(flex.size.aspectRatio, to: layout)
        setMargin(flex.margin, to: layout)
        setPadding(flex.padding, to: layout)
        setPosition(flex.position, to: layout)
    }
    
    // MARK: - Flex Layout Methods
    
    private func setWidth(_ width: UnitValue?, to layout: YGLayout) {
        if let width = width {
            layout.width = yogaTranslator.translate(width)
        }
    }
    
    private func setHeight(_ height: UnitValue?, to layout: YGLayout) {
        if let height = height {
            layout.height = yogaTranslator.translate(height)
        }
    }
    
    private func setMaxWidth(_ maxWidth: UnitValue?, to layout: YGLayout) {
        if let maxWidth = maxWidth {
            layout.maxWidth = yogaTranslator.translate(maxWidth)
        }
    }
    
    private func setMaxHeight(_ maxHeight: UnitValue?, to layout: YGLayout) {
        if let maxHeight = maxHeight {
            layout.maxHeight = yogaTranslator.translate(maxHeight)
        }
    }
    
    private func setMinWidth(_ minWidth: UnitValue?, to layout: YGLayout) {
        if let minWidth = minWidth {
            layout.minWidth = yogaTranslator.translate(minWidth)
        }
    }
    
    private func setMinHeight(_ minHeight: UnitValue?, to layout: YGLayout) {
        if let minHeight = minHeight {
            layout.minHeight = yogaTranslator.translate(minHeight)
        }
    }
    
    private func setBasis(_ basis: UnitValue?, to layout: YGLayout) {
        if let basis = basis {
            layout.flexBasis = yogaTranslator.translate(basis)
        } else {
            layout.flexBasis = YGValue(value: 0.0, unit: .auto) // TODO: Check this
        }
    }
    
    private func setAspectRatio(_ aspectRatio: Double?, to layout: YGLayout) {
        if let aspectRatio = aspectRatio {
            layout.aspectRatio = CGFloat(aspectRatio)
        }
    }
    
    private func setMargin(_ margin: Flex.EdgeValue, to layout: YGLayout) {
        
        if let all = margin.all {
            layout.margin = yogaTranslator.translate(all)
            return
        }
        
        if let left = margin.left {
            layout.marginLeft = yogaTranslator.translate(left)
        }
        
        if let top = margin.top {
            layout.marginTop = yogaTranslator.translate(top)
        }
        
        if let right = margin.right {
            layout.marginRight = yogaTranslator.translate(right)
        }
        
        if let bottom = margin.bottom {
            layout.marginBottom = yogaTranslator.translate(bottom)
        }
        
        if let start = margin.start {
            layout.marginStart = yogaTranslator.translate(start)
        }
        
        if let end = margin.end {
            layout.marginEnd = yogaTranslator.translate(end)
        }
        
        if let horizontal = margin.horizontal {
            layout.marginHorizontal = yogaTranslator.translate(horizontal)
        }
        
        if let vertical = margin.vertical {
            layout.marginVertical = yogaTranslator.translate(vertical)
        }
        
    }
    
    private func setPadding(_ padding: Flex.EdgeValue, to layout: YGLayout) {
        
        if let all = padding.all {
            layout.padding = yogaTranslator.translate(all)
            return
        }
        
        if let left = padding.left {
            layout.paddingLeft = yogaTranslator.translate(left)
        }
        
        if let top = padding.top {
            layout.paddingTop = yogaTranslator.translate(top)
        }
        
        if let right = padding.right {
            layout.paddingRight = yogaTranslator.translate(right)
        }
        
        if let bottom = padding.bottom {
            layout.paddingBottom = yogaTranslator.translate(bottom)
        }
        
        if let start = padding.start {
            layout.paddingStart = yogaTranslator.translate(start)
        }
        
        if let end = padding.end {
            layout.paddingEnd = yogaTranslator.translate(end)
        }
        
        if let horizontal = padding.horizontal {
            layout.paddingHorizontal = yogaTranslator.translate(horizontal)
        }
        
        if let vertical = padding.vertical {
            layout.paddingVertical = yogaTranslator.translate(vertical)
        }
        
    }
    
    private func setPosition(_ position: Flex.EdgeValue, to layout: YGLayout) {
        
        if let all = position.all {
            let value = yogaTranslator.translate(all)
            layout.top = value
            layout.left = value
            layout.bottom = value
            layout.right = value
            return
        }
        
        if let left = position.left {
            layout.left = yogaTranslator.translate(left)
        }

        if let top = position.top {
            layout.top = yogaTranslator.translate(top)
        }

        if let right = position.right {
            layout.right = yogaTranslator.translate(right)
        }

        if let bottom = position.bottom {
            layout.bottom = yogaTranslator.translate(bottom)
        }

        if let start = position.start {
            layout.start = yogaTranslator.translate(start)
        }

        if let end = position.end {
            layout.end = yogaTranslator.translate(end)
        }
        
    }
    
}
