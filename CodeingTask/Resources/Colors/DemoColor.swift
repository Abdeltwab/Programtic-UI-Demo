//
//  DemoColor.swift
//  CodeingTask
//
//  Created by Abdeltawab Mohamed on 04/01/2022.
//

import Foundation
import UIKit

enum DemoColor: String {
    case topBlueColor
    case bottomBlueColor
    case leftSkyColor
    case rightSkyColor
    
}

struct ColorsManger {
    
   static func getGardiateLayer(for colorOne: DemoColor , colorTwo : DemoColor ) -> CAGradientLayer{
       let layer = CAGradientLayer()
       layer.colors = [colorOne ,colorTwo]
       layer.locations =  [0.0, 1.0]
       return layer

    }
}


extension UIColor {
    
    static func color(for demoColor: DemoColor) -> UIColor {
        UIColor(named: demoColor.rawValue) ?? UIColor()
    }
    
}
