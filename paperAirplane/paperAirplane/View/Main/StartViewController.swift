//
//  StartViewController.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/05/21.
//

import UIKit

class StartViewController: UIViewController {

    final class FirstLaunch {
        let wasLaunchedBefore: Bool
        var isFirstLaunch: Bool { return !wasLaunchedBefore }
        init(getWasLaunchedBefore: () -> Bool,
             setWasLaunchedBefore: (Bool) -> ()) {
            let wasLaunchedBefore = getWasLaunchedBefore()
            self.wasLaunchedBefore = wasLaunchedBefore
            if !wasLaunchedBefore { setWasLaunchedBefore(true) }
        }
        convenience init(userDefaults: UserDefaults, key: String) {
            self.init(getWasLaunchedBefore: { userDefaults.bool(forKey: key) }, setWasLaunchedBefore: { userDefaults.set($0, forKey: key) })
        }
    }
    
    // 첫 실행인지 확인
    let fistLaunch = FirstLaunch(userDefaults: .standard, key: "com.any-suggestion.FirstLaunch.WasLaunchedBefore")
    
    // 항상 첫 실행으로 (테스트용)
    let alwaysFirstLaunch = FirstLaunch(getWasLaunchedBefore: { return false }, setWasLaunchedBefore: { _ in })
    
    //MARK: - LifeCycle
    override func viewDidAppear(_ animated: Bool) {
        checkDeviceNetworkStatusAndPresentView()
        
    }
    
    //MARK: - function
    func checkDeviceNetworkStatusAndPresentView() {
        if(DeviceManager.shared.networkStatus) {
            // 네트워크 연결 O
            let mainNav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNavigationController")
            mainNav.modalPresentationStyle = .fullScreen
            mainNav.modalTransitionStyle = .crossDissolve
            self.present(mainNav, animated: true, completion: nil)
        } else {
            // 네트워크 연결 X
            CustomAlert.shared.showAlert(vc: self, alertType: .onlyConfirm, alertText: "서버에 연결할 수 없습니다.\n네트워크 연결 상태를 확인하고 다시 시도해주세요.", confirmButtonText: "확인") {
                self.checkDeviceNetworkStatusAndPresentView()
            }
        }
    }

}
