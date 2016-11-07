//
//  CircleButton.swift
//  BoxCricket
//
//  Created by Fnu, Rohit on 11/2/16.
//  Copyright © 2016 Fnu, Rohit. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0
        {
        didSet{
            setUpView()
        }
    }
    
    override func prepareForInterfaceBuilder()
    {
        setUpView()
    }
    
    func setUpView()
    {
        layer.cornerRadius = cornerRadius
    }

}
