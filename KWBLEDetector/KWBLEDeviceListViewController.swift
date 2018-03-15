//
//  KWBLEDeviceListViewController.swift
//  KWBLEDetector
//
//  Created by Kuan-Wei Lin on 1/10/18.
//  Copyright © 2018 cracktheterm. All rights reserved.
//

import UIKit
import CoreBluetooth

public class KWBLEDeviceListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  KWBLEDetectorProtocol {

    var tableView: UITableView!
    
    let bleDetector = KWBLECentral()
    
    var peripherals = [CBPeripheral]()
    
    override public func viewDidLoad()
    {
        super.viewDidLoad()
        
        bleDetector.delegate = self
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    public func showBleDeviceList()
    {
        let topVC = UIApplication.topViewController()
        view.addSubview(tableView)
        topVC?.present(self, animated: true, completion: nil)
    }
    
    public func returnBleDeviceList() -> UIViewController {
        view.addSubview(tableView)
        return self
    }
    
    public func didUpdateState(_ kwBleCentral: KWBLECentral, _ central: CBCentralManager)
    {
        if central.state == .poweredOn
        {
            print("power on")
        }
    }
    
    public func didDiscoverPeripherals(_ kwBleCentral: KWBLECentral, _ peripheral: CBPeripheral)
    {
        if !peripherals.contains(peripheral)
        {
            peripherals.append(peripheral)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return peripherals.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let peripheral = peripherals[indexPath.row]
        
        cell.textLabel?.text = peripheral.name
        
        return cell
    }
}

extension UIApplication
{
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
