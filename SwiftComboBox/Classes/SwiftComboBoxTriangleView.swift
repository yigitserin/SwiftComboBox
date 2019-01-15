//
//  SwiftComboBoxTriangleView.swift
//  Pods-SwiftComboBox_Example
//
//  Created by Yigit Serin on 15.01.2019.
//

import UIKit

class SwiftComboBoxTriangleView: UIView {
    
    var arrowColor: UIColor = UIColor.black
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.maxY))
        context.closePath()
        
        context.setFillColor(arrowColor.cgColor)
        context.fillPath()
    }
 

}
