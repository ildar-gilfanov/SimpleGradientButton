//  ExampleViewController.swift
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
import SimpleGradientButton

class ExampleViewController: UIViewController {
    override func loadView() {
        view = UIScrollView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        // Manual layout
        
        let button1 = GradientButton()
        button1.gradientDirection = .horizontal
        button1.setTitle("Press me!", for: .normal)
        if let color1 = GradientColor(color: .yellow, position: 0),
            let color2 = GradientColor(color: .green, position: 1.0) {
            
            button1.setGradientColors([color1, color2], for: .normal)
        }
        
        contentView.addSubview(button1)
        button1.frame.size = CGSize(width: 200.0, height: 50.0)
        
        manualLayoutbutton = button1
        
        // Autolayout
        
        let button2 = GradientButton()
        button2.cornerRadius = .specific(5.0)
        button2.setTitle("Press me!", for: .normal)
        if let color1 = GradientColor(color: .blue, position: 0),
            let color2 = GradientColor(color: .purple, position: 1.0)  {
            
            button2.setGradientColors([color1, color2], for: .normal)
        }
        
        contentView.addSubview(button2)
        button2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50.0),
            button2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50.0),
            button2.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 150.0),
            button2.heightAnchor.constraint(equalToConstant: 50.0),
        ])
        
        // Specific gradient for different button states
        
        let button3 = GradientButton()
        button3.disableGradientChangeAnimation = false
        button3.gradientDirection = .horizontal
        button3.setTitle("Deselected", for: .normal)
        button3.setTitleColor(.black, for: .normal)
        button3.addTarget(self,
                          action: #selector(toggleSelection),
                          for: .touchUpInside)
        if let color1 = GradientColor(color: .red, position: 0),
            let color2 = GradientColor(color: .yellow, position: 0.45),
            let color3 = GradientColor(color: .yellow, position: 0.55),
            let color4 = GradientColor(color: .red, position: 1.0) {
            
            button3.setGradientColors([color1, color2, color3, color4], for: .normal)
        }
        if let color1 = GradientColor(color: .red, position: 0),
            let color2 = GradientColor(color: .yellow, position: 0.2),
            let color3 = GradientColor(color: .yellow, position: 0.8),
            let color4 = GradientColor(color: .red, position: 1.0)  {
            
            button3.setGradientColors([color1, color2, color3, color4], for: [.highlighted, .normal])
        }
        if let color1 = GradientColor(color: .green, position: 0),
            let color2 = GradientColor(color: .yellow, position: 0.45),
            let color3 = GradientColor(color: .yellow, position: 0.55),
            let color4 = GradientColor(color: .green, position: 1.0)  {
            
            button3.setGradientColors([color1, color2, color3, color4], for: .selected)
        }
        if let color1 = GradientColor(color: .green, position: 0),
            let color2 = GradientColor(color: .yellow, position: 0.2),
            let color3 = GradientColor(color: .yellow, position: 0.8),
            let color4 = GradientColor(color: .green, position: 1.0)  {
            
            button3.setGradientColors([color1, color2, color3, color4], for: [.highlighted, .selected])
        }
        
        contentView.addSubview(button3)
        button3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50.0),
            button3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50.0),
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 50.0),
            button3.heightAnchor.constraint(equalToConstant: 50.0),
        ])
        
        selectableButton = button3
        
        // Single color gradient
        
        let button4 = GradientButton()
        button4.setTitle("Don't press me!", for: .normal)
        button4.isEnabled = false
        if let color1 = GradientColor(color: UIColor.blue.withAlphaComponent(0.2), position: 0) {
            button4.setGradientColors([color1], for: .disabled)
        }
        
        contentView.addSubview(button4)
        button4.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button4.topAnchor.constraint(equalTo: button3.bottomAnchor, constant: 50.0),
            button4.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button4.heightAnchor.constraint(equalToConstant: 50.0),
            button4.widthAnchor.constraint(equalToConstant: 280.0)
        ])
        
        // Animation
        
        let button5 = GradientButton()
        button5.cornerRadius = .specific(5.0)
        button5.setTitle("Press me!", for: .normal)
        button5.setTitleColor(.black, for: .normal)
        button5.addTarget(self,
                          action: #selector(playAnimation),
                          for: .touchUpInside)
        if let color1 = GradientColor(color: .green, position: 0),
            let color2 = GradientColor(color: .yellow, position: 1.0) {
            button5.setGradientColors([color1, color2], for: .normal)
        }
        
        contentView.addSubview(button5)
        button5.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = button5.heightAnchor.constraint(equalToConstant: 50.0)
        NSLayoutConstraint.activate([
            button5.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50.0),
            button5.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50.0),
            button5.topAnchor.constraint(equalTo: button4.bottomAnchor, constant: 50.0),
            button5.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50.0),
            heightConstraint,
        ])
        
        animationButton = button5
    }
    
    // MARK: - Layout
    
    private var manualLayoutbutton: GradientButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        manualLayoutbutton.center = CGPoint(x: view.bounds.width / 2, y: 70.0)
    }
    
    // MARK: - Selection
    
    private var selectableButton: GradientButton!
    
    @objc func toggleSelection() {
        selectableButton.isSelected.toggle()
        selectableButton.setTitle(selectableButton.isSelected ? "Selected" : "Deselected",
                                  for: .normal)
    }
    
    // MARK: - Animation
    
    private var animationButton: GradientButton!
    private var heightConstraint: NSLayoutConstraint!
    
    @objc func playAnimation() {
        heightConstraint.constant = 100.0
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
}
