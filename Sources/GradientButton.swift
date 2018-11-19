//  GradientButton.swift
//
//  Copyright (c) 2018 Ildar Gilfanov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

open class GradientButton: UIButton {
    public enum GradientDirection {
        case vertical
        case horizontal
    }
    public enum CornerRadius {
        case automatic
        case specific(CGFloat)
    }
    
    open var disableGradientChangeAnimation = true
    open var gradientDirection: GradientDirection = .vertical {
        didSet {
            updateGradient()
        }
    }
    open var cornerRadius: CornerRadius = .automatic {
        didSet {
            updateGradient()
        }
    }
    open override var isEnabled: Bool {
        didSet {
            updateGradient()
        }
    }
    open override var isSelected: Bool {
        didSet {
            updateGradient()
        }
    }
    open override var isHighlighted: Bool {
        didSet {
            updateGradient()
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    private var gradientColors: [State: [GradientColor]] = [:]
    
    // MARK: - Init
    
    public init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        layer.insertSublayer(gradientLayer, at: 0)
        layer.masksToBounds = true
        
        updateGradient()
    }
    
    // MARK: - Accessors
    
    open func setGradientColors(_ gradientColors: [GradientColor], for state: State) {
        self.gradientColors[state] = gradientColors
        
        updateGradient()
    }
    
    open func gradientColors(for state: State) -> [GradientColor]? {
        return gradientColors[state] ?? gradientColors[.normal] ?? nil
    }
    
    // MARK: - UI
    
    open override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        gradientLayer.frame = layer.bounds
        
        switch cornerRadius {
        case .automatic:
            layer.cornerRadius = layer.bounds.height / 2
        case let .specific(radius):
            layer.cornerRadius = radius
        }
    }
    
    // MARK: - Private
    
    private func updateGradient() {
        var colors = gradientColors(for: state) ?? []
        if colors.count == 1 {
            colors = [
                GradientColor(color: colors[0].color, position: 0)!, // swiftlint:disable:this force_unwrapping
                GradientColor(color: colors[0].color, position: 1.0)!, // swiftlint:disable:this force_unwrapping
            ]
        }
        
        let sortedColors = colors.sorted { $0.position < $1.position }
        
        CATransaction.begin()
        CATransaction.setDisableActions(disableGradientChangeAnimation)
        
        gradientLayer.colors = sortedColors.map { $0.color.cgColor }
        gradientLayer.locations = sortedColors.map { $0.position }.map(NSNumber.init)
        gradientLayer.startPoint = gradientDirection == .vertical ? .bottomPoint : .leftPoint
        gradientLayer.endPoint = gradientDirection == .vertical ? .topPoint : .rightPoint
        
        CATransaction.commit()
    }
}
