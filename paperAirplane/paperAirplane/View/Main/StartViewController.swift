//
//  StartViewController.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/05/21.
//

import UIKit
import Firebase

class StartViewController: UIViewController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkDeviceNetworkStatusAndPresentView()
    }
    
    //MARK: - function
    func checkDeviceNetworkStatusAndPresentView() {
        if (DeviceManager.shared.networkStatus) {
            // 네트워크 연결 O
            if Auth.auth().currentUser == nil {
                // 로그인 상태가 아니면
                let loginVC = getVC("LoginViewController")
                loginVC.modalPresentationStyle = .fullScreen
                loginVC.modalTransitionStyle = .crossDissolve
                present(loginVC, animated: true)
            } else {
                // 로그인 상태면
                let mainNC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNavigationController")
                mainNC.modalPresentationStyle = .fullScreen
                mainNC.modalTransitionStyle = .crossDissolve
                present(mainNC, animated: true)
            }
        } else {
            // 네트워크 연결 X
            show(
                alertType: .canCancel,
                alertText: "서버에 연결할 수 없습니다.\n네트워크 연결 상태를 확인하고 다시 시도해주세요.",
                cancelButtonText: "종료",
                confirmButtonText: "재시도"
            )
        }
    }
}

extension StartViewController: CustomAlertDelegate {
    func action() {
        self.checkDeviceNetworkStatusAndPresentView()
    }
    
    func exit() {
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            Darwin.exit(0)
        }
    }
}
