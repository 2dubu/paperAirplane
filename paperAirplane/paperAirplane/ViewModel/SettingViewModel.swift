//
//  SettingViewModel.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/06/19.
//

import Foundation
import LocalAuthentication

class SettingViewModel {
    
    enum BiometryType {
        case faceId
        case touchId
        case none
    }
    
    let authContext = LAContext()
    
    func getBiometryType() -> BiometryType {
        switch authContext.biometryType {
        case .faceID:
            return .faceId
        case .touchID:
            return .touchId
        default:
            return .none
        }
    }
}
