//
//  KWBLECentral.swift
//  KWBLEDetector
//
//  Created by Kuan-Wei Lin on 1/7/18.
//  Copyright © 2018 cracktheterm. All rights reserved.
//

import Foundation
import CoreBluetooth

public enum KWBLESendDataError: Error {
    case KWBLECharacteristicNotFound
}

public protocol KWBLEDetectorProtocol
{
    func didUpdateState(_ kwBleCentral: KWBLECentral, _ central: CBCentralManager)
    
    func didDiscoverPeripherals(_ kwBleCentral: KWBLECentral, _ peripheral: CBPeripheral)
}

public class KWBLECentral:NSObject, CBCentralManagerDelegate
{
    public var delegate: KWBLEDetectorProtocol?
    
    var centralManager: CBCentralManager!
    var connectPeripheral: CBPeripheral!
    var charDictionary = [String: CBCharacteristic]()
    
    var peripherals = [CBPeripheral]()
    
    public override init()
    {
        super.init()
        let queue = DispatchQueue.global()
        centralManager = CBCentralManager(delegate: self, queue: queue, options: [:])
    }
    
    public func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        switch central.state {
        case .poweredOn:
            print("power on")
            break
        case .poweredOff:
            print("power off")
            break
        case .unsupported:
            print("unsupported")
            break
        case .unauthorized:
            print("unauthorized")
            break
        default:
            break
        }
        
        guard central.state == .poweredOn else
        {
            return
        }
        
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        
        delegate?.didUpdateState(self, central)
    }
    
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
    {
        if !peripherals.contains(peripheral)
        {
            print("藍牙裝置 = \(String(describing: peripheral.name))")
            print("rssi = \(String(describing: peripheral.readRSSI()))")
            print("services = \(String(describing: peripheral.services))")
            print("state = \(String(describing: peripheral.state))")
            peripherals.append(peripheral)
            delegate?.didDiscoverPeripherals(self, peripheral)
        }
    }
    
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral)
    {
        
    }
    
}
