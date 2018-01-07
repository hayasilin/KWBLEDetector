//
//  ViewController.swift
//  KWBLEDetector_Demo
//
//  Created by Kuan-Wei Lin on 1/7/18.
//  Copyright © 2018 cracktheterm. All rights reserved.
//

import UIKit
import KWBLEDetector
import CoreBluetooth

class ViewController: UIViewController, KWBLEDetectorProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    let bleDetector = KWBLECentral()
    
    var peripherals = [CBPeripheral]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        bleDetector.delegate = self
        
    }
    
    func didUpdateState(_ kwBleCentral: KWBLECentral, _ central: CBCentralManager)
    {
        if central.state == .poweredOn
        {
            print("power on")
        }
    }
    
    func didDiscoverPeripherals(_ kwBleCentral: KWBLECentral, _ peripheral: CBPeripheral)
    {
        if !peripherals.contains(peripheral)
        {
            peripherals.append(peripheral)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let peripheral = peripherals[indexPath.row]
        
        cell.textLabel?.text = peripheral.name
        
        return cell
    }
}






