//
//  BeaconScaner.swift
//  Wibeacon
//
//  Created by NaXin on 2019/10/31.
//  Copyright © 2019年 NaXin. All rights reserved.
//

import UIKit
import CoreBluetooth

///
/// BeaconScannerDelegate
///
/// Implement this to receive notifications about beacons.
protocol BeaconScannerDelegate {
    func didFindBeacon(beaconScanner: BeaconScanner, info: String, log: String)
}

///
/// BeaconScanner
///
class BeaconScanner: NSObject, CBCentralManagerDelegate {
    
    var delegate: BeaconScannerDelegate?
    
    private var altBeaconParser: RNLBeaconParser!
    private var centralManager: CBCentralManager!
    private var scanning: Bool!
    
    override init() {
        super.init()
        
        self.centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        
        altBeaconParser = RNLBeaconParser()
        try! altBeaconParser.setBeaconLayout("m:2-3=beac,i:4-19,i:20-21,i:22-23,p:24-24,d:25-25")
        scanning = false
    }
    
    // Async Start scanning.
    func startScanning() {
        if self.centralManager.state != .poweredOn {
            NSLog("CentralManager state is %d, cannot start scan", self.centralManager.state.rawValue)
        } else {
            NSLog("Starting to scan for beacons")
            self.centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
            self.scanning = true
        }
    }
    
    func stopScanning() {
        self.centralManager.stopScan()
    }
    
    // call back for after the state update
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn && self.scanning {
            self.centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        }
    }
    
    ///
    /// Core Bluetooth CBCentralManager callback when we discover a beacon. We're not super
    /// interested in any error situations at this point in time.
    ///
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let serviceData = advertisementData[CBAdvertisementDataServiceDataKey] as? [AnyHashable: Any]
        var beacon: RNLBeacon? = nil
        let adData = advertisementData[CBAdvertisementDataManufacturerDataKey] as? Data
        
        if adData != nil{
            beacon = altBeaconParser.fromScanData(adData, withRssi: RSSI, forDevice: peripheral, serviceUuid: nil)
        }
        else if serviceData != nil {
            let defaultkeys = [AnyHashable: Any]()
            for key in serviceData?.keys ?? defaultkeys.keys {
                let uuidString = (key as? CBUUID)?.uuidString
                let scanner = Scanner(string: uuidString ?? "")
                var uuidLongLong: UInt64 = 0

                scanner.scanHexInt64(&uuidLongLong)
                let uuidNumber = NSNumber(value: Int64(uuidLongLong))
                let adServiceData = serviceData?[key] as? Data
                if adServiceData != nil {
                    beacon = altBeaconParser.fromScanData(adServiceData, withRssi: RSSI, forDevice: peripheral, serviceUuid: uuidNumber)
                }
            }
        }
        if beacon != nil {
            if let id1 = beacon?.id1, let id2 = beacon?.id2, let id3 = beacon?.id3, let rs = beacon?.rssi {
                let ts = getTimeStamp()
                let info = String(format: "At %@ Detected beacon: %@, %@", ts, id1, rs)
                let log = String(format: "%@+%@+%@+%@+%@\n", id1, id2, id3, ts, rs)
                delegate?.didFindBeacon(beaconScanner: self, info: info, log: log)
            }
        }
    }
    
    func getTimeStamp() -> String {
        let now = Date().timeIntervalSince1970
        let millisecond = CLongLong(round(now * 1000))
        return "\(millisecond)"
    }
}
