//
//  ViewController.swift
//  SwiftComboBox
//
//  Created by yigitserin on 01/15/2019.
//  Copyright (c) 2019 yigitserin. All rights reserved.
//

import UIKit
import SwiftComboBox

class ViewController: UIViewController {

    @IBOutlet weak var swiftComboBox: SwiftComboBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Version 0.1.3
        
        swiftComboBox.context = self
        swiftComboBox.dataSource = ["Apple", "Samsung", "Microsoft", "Google", "Intel", "IBM", "Facebook", "Tencent", "Oracle"]
        swiftComboBox.didSelectRow = { (index: Int, item: String) in
            print(item)
        }
        
        //swiftComboBox.disabledBackgroundColor = UIColor.green
        //swiftComboBox.arrowColor = UIColor.red
        //swiftComboBox.borderColor = UIColor.blue
        //swiftComboBox.effectType = .blur
    }
}

