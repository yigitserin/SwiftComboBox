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
        
        swiftComboBox.dataSource = ["Apple", "Samsung", "Microsoft", "Google", "Intel", "IBM", "Facebook", "Tencent", "Oracle"]
        swiftComboBox.didSelectRow = { (index: Int, item: String) in
            print(item)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

