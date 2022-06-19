//
//  DeviceConfig.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/05/21.
//

import Foundation
import SystemConfiguration
import UIKit

class DeviceManager {
    static let shared : DeviceManager = DeviceManager()
    
    var networkStatus : Bool {
        get { return checkDeviceNetworkStatus() }
    }
    
    var isRunningOnDevice: Bool = {
        #if targetEnvironment(simulator)
            return false
        #else
            return true
        #endif
    }()
    
    private init() {
    }
    
}

var hasNotch: Bool {
    let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    return bottom > 0
}

func checkDeviceNetworkStatus() -> Bool {
    print("Check to Device Natwork Status....")
    var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
    if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
        return false
    }
    
    // Working for Cellular and WIFI
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    let ret = (isReachable && !needsConnection)
    return ret
}
