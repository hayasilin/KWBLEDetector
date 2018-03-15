//
//  ViewController.swift
//  KWBLEDetector_Demo
//
//  Created by Kuan-Wei Lin on 1/7/18.
//  Copyright © 2018 cracktheterm. All rights reserved.
//

import UIKit
import KWBLEDetector


class ViewController: UIViewController {
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func showBLEList(_ sender: UIButton)
    {
        let kwBLEVC = KWBLEDeviceListViewController()
        kwBLEVC.showBleDeviceList()
//        self.present(kwBLEVC.returnBleDeviceList(), animated: true, completion: nil)
    }
    
    
}






