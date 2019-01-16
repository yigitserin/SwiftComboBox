//
//  SwiftComboBox.swift
//  SwiftComboBox
//
//  Created by Yigit Serin on 14.01.2019.
//  Copyright © 2019 Yigit Serin. All rights reserved.
//

import UIKit

public typealias SwiftComboBoxSelectClosure = (Int, String) -> Void

public class SwiftComboBox: UIView, UIViewControllerTransitioningDelegate {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var triangle: SwiftComboBoxTriangleView!
    
    //Visual customization parameters
    public var effectType: SwiftComboBoxEffectType = .dark
    public var arrowColor: UIColor = UIColor(red:0.46, green:0.46, blue:0.46, alpha:1.0){
        didSet{
            triangle.arrowColor = arrowColor
        }
    }
    public var borderColor: UIColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0){
        didSet{
            contentView.layer.borderColor = borderColor.cgColor
        }
    }
    public var disabledBackgroundColor: UIColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0){
        didSet{
            if isEnabled{
                backgroundView.backgroundColor = UIColor.white
            }else{
                backgroundView.backgroundColor = disabledBackgroundColor
            }
        }
    }
    
    public var context: UIViewController?
    public var didSelectRow: SwiftComboBoxSelectClosure?
    public var dataSource:[String] = []{
        didSet{
            convertedDataSource.removeAll()
            
            for i in 0..<dataSource.count{
                let data = SwiftComboBoxData(id: i, text: dataSource[i])
                convertedDataSource.append(data)
            }
            
            if let firstItem = convertedDataSource.first{
                selectedItem = firstItem
            }else{
                selectedItem = nil
            }
        }
    }
    
    private var convertedDataSource: [SwiftComboBoxData] = []
    
    public var isEnabled: Bool = true{
        didSet{
            if isEnabled{
                backgroundView.backgroundColor = UIColor.white
            }else{
                backgroundView.backgroundColor = disabledBackgroundColor
            }
        }
    }
    
    private var labelString: String = ""{
        didSet{
            label.text = labelString
        }
    }
    
    public var selectedItem: SwiftComboBoxData?{
        didSet{
            if let item = selectedItem{
                labelString = item.text
                didSelectRow?(item.id, item.text)
            }else{
                labelString = ""
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle(for: SwiftComboBox.self).loadNibNamed("SwiftComboBox", owner: self, options: nil)
        fixInView(self)
        setUI()
        setTap()
    }
    
    private func fixInView(_ container: UIView!){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.frame = container.frame
        container.addSubview(contentView)
        NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    private func setUI(){
        backgroundColor = UIColor.clear
        contentView.layer.borderColor = borderColor.cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        triangle.arrowColor = arrowColor
    }
    
    private func setTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapComboBox))
        addGestureRecognizer(tap)
    }
    
    @objc func didTapComboBox(){
        if !isEnabled{ return }
        
        //Launch choice
        let controller = SwiftComboBoxChoiceViewController(nibName: "SwiftComboBoxChoiceViewController", bundle: Bundle(for: SwiftComboBox.self))
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
        controller.originalDataSource = convertedDataSource
        controller.swiftComboBox = self
        context?.present(controller, animated: true, completion: nil)
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let swiftComboBoxPresentationController = SwiftComboBoxPresentationController(presentedViewController: presented, presenting: presenting)
        swiftComboBoxPresentationController.effectType = self.effectType
        return swiftComboBoxPresentationController
    }
}
