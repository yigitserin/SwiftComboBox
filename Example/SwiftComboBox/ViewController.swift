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
    
    @IBAction func enabledSwitchChanged(_ sender: UISwitch) {
        
        swiftComboBox.isEnabled = sender.isOn
    }
    
    @IBAction func dataSwitchChanged(_ sender: UISwitch) {
        
        if sender.isOn{
            swiftComboBox.dataSource = data
        }else{
            swiftComboBox.dataSource = []
        }
    }
    
    @IBOutlet weak var swiftComboBox: SwiftComboBox!
    let data = ["Apple", "Samsung", "Microsoft", "Google", "Intel", "IBM", "Facebook", "Tencent", "Oracle"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Version 0.1.3
        
        swiftComboBox.context = self
        swiftComboBox.dataSource = data
        swiftComboBox.didSelectRow = { (index: Int, item: String) in
            print(item)
        }
        
        //swiftComboBox.selectedIndex = 8
        
        //swiftComboBox.disabledBackgroundColor = UIColor.green
        //swiftComboBox.arrowColor = UIColor.red
        //swiftComboBox.borderColor = UIColor.blue
        //swiftComboBox.effectType = .blur
    }
}

