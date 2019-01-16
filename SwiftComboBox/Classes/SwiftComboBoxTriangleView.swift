//
//  SwiftComboBoxTriangleView.swift
//  Pods-SwiftComboBox_Example
//
//  Created by Yigit Serin on 15.01.2019.
//

import UIKit

class SwiftComboBoxTriangleView: UIView {
    
    public var arrowColor: UIColor = UIColor.black{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY * 0.25))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.25))
        context.addLine(to: CGPoint(x: (rect.maxX * 0.5), y: rect.maxY * 0.75 ))
        context.closePath()
        
        context.setFillColor(arrowColor.cgColor)
        context.fillPath()
    }
 

}
