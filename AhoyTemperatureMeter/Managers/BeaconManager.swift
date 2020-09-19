//
//  BeaconManager.swift
//  AhoyTemperatureMeter
//
//  Created by sajeev Raj on 19/09/2020.
//  Copyright © 2020 NewsApp. All rights reserved.
//

import Foundation
import MKBeaconXProSDK

class iBeaconManager: NSObject {
    private override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveHTDataHandler), name: .MKBXPReceiveHTData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveRecordHTData), name: .MKBXPReceiveRecordHTData, object: nil)
    }
    
    static var shared = iBeaconManager()
    private var scanForBeaconsCompletion: (([Beacon]?, Error?) -> Void)?

}

extension iBeaconManager {
    @objc func receiveHTDataHandler () {
        print(#function)
    }
    
    @objc func receiveRecordHTData () {
        print(#function)
    }
    
    func scanForBeacons(completion: (([Beacon]?, Error?) -> Void)?) {
        MKBXPCentralManager.shared().scanDelegate = self
        
        scanForBeaconsCompletion = completion
        perform(#selector(showCentralStatus), with: nil, afterDelay: 0.5)
        startScan()
    }
    
    func startScan() {
        MKBXPCentralManager.shared().startScanPeripheral()
    }
    
    @objc func showCentralStatus() {
        if #available(iOS 11.0, *), MKBXPCentralManager.shared().managerState != .enable {
            AlertController.show(error: AhoyError.create("The current system of bluetooth is not available!"))
        }
    }
}

extension iBeaconManager: MKBXPScanDelegate {
    
    func bxp_didReceiveBeacon(_ beaconList: [MKBXPBaseBeacon]!) {
        scanForBeaconsCompletion?(beaconList as? [Beacon] ?? [], nil)
        print(beaconList ?? [])
        print("yay")
    }
}

class Beacon: MKBXPBaseBeacon {}

class AhoyError {
    class func create(_ message: String) -> Error {
        let error = NSError(domain: "error", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
        return error as Error
    }
}
