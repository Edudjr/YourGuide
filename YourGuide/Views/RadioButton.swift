//
//  RadioButton.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

import UIKit

@IBDesignable
class RadioButton: UIButton {
    var alternateButtons: Array<RadioButton>?
    
    @IBInspectable public var selectedColor: UIColor? = UIColor.blue {
        didSet {
            self.layer.borderColor = selectedColor?.cgColor
        }
    }
    
    @IBInspectable public var unselectedColor: UIColor? = UIColor.gray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
        self.setImage(nil, for: .normal)
    }
    
    func unselectAlternateButtons(){
        if alternateButtons != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButtons! {
                aButton.isSelected = false
            }
        } else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = selectedColor?.cgColor
                self.layer.backgroundColor = selectedColor?.cgColor
            } else {
                self.layer.borderColor = unselectedColor?.cgColor
                self.layer.backgroundColor = UIColor.clear.cgColor
            }
        }
    }
}
