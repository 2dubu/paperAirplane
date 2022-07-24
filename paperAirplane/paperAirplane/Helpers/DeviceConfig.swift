//
//  DeviceConfig.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/05/21.
//

import Foundation
import UIKit

class DeviceManager {
    static let shared : DeviceManager = DeviceManager()
    
    var isRunningOnDevice: Bool = {
        #if targetEnvironment(simulator)
            return false
        #else
            return true
        #endif
    }()
    
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    
    private init() {
    }
}

