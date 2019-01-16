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
        
        swiftComboBox.context = self
        swiftComboBox.dataSource = ["Apple", "Samsung", "Microsoft", "Google", "Intel", "IBM", "Facebook", "Tencent", "Oracle", "Very Long Item To Test The Two Line Or Whatever Dummy Lorem","Apple", "Samsung", "Microsoft", "Google", "Intel"]
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

