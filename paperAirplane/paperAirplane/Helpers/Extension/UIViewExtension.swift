//
//  UIViewExtension.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/06/11.
//

import Foundation
import UIKit

extension UIView{
    func setGradient(colors: [CGColor]){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
