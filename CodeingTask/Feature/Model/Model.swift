//
//  Model.swift
//  CodeingTask
//
//  Created by Abdeltawab Mohamed on 04/01/2022.
//

import UIKit

struct  TopViewModel {
    
    var title : String
    var subTitle : String
    var description : String
    var image: UIImage
    var color: UIColor

    internal init(title: String, subTitle: String, description: String, image: UIImage,color:UIColor) {
        self.title = title
        self.subTitle = subTitle
        self.description = description
        self.image = image
        self.color = color
    }

}

struct  MiddleViewModel {
    
    var period : String
    var dateType : String
    var price : String
    var isPopular: Bool
    
    init(period: String, dateType: String, price: String, isPopular: Bool) {
        self.period = period
        self.dateType = dateType
        self.price = price
        self.isPopular = isPopular
    }
    
    
}
