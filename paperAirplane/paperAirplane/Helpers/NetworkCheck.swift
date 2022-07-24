//
//  NetworkCheck.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/07/24.
//

import UIKit
import Network

final class NetworkCheck {
    static let shared = NetworkCheck()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    /// 네트워크 오류 custom alert가 표시되었는지에 대한 여부
    /// custom alert의 중복을 방지하기 위함
    private var customAlertViewIsVisible = false

    /// 연결타입
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }

    /// monotior 초기화
    private init() {
        monitor = NWPathMonitor()
    }

    /// Network Monitoring 시작
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            self.isConnected = path.status == .satisfied
            self.getConnectionType(path)
            
            self.checkNetworkAndShowAlert()
        }
    }

    /// Network Monitoring 종료
    public func stopMonitoring() {
        monitor.cancel()
    }

    /// Network 연결 타입
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
    
    /// Network 체크 후 custom alert 띄우기
    private func checkNetworkAndShowAlert() {
        if self.isConnected == true {
            print("연결됨!")
        } else {
            print("연결안됨!")
            showNetworkErrorAlert()
        }
    }
    
    private func showNetworkErrorAlert() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.customAlertViewIsVisible == true { return }
            
            guard let customAlertViewController = UIStoryboard(
                name: "CustomAlertViewController",
                bundle: nil
            ).instantiateViewController(withIdentifier: "CustomAlertViewController") as? CustomAlertViewController else { return }
            customAlertViewController.delegate = self
            customAlertViewController.alertType = .canCancel
            customAlertViewController.alertText = "서버에 연결할 수 없습니다.\n네트워크 연결 상태를 확인하고 다시 시도해주세요."
            customAlertViewController.cancelButtonText = "종료"
            customAlertViewController.confirmButtonText = "재시도"
            
            customAlertViewController.modalPresentationStyle = .overFullScreen
            customAlertViewController.modalTransitionStyle = .crossDissolve
            UIApplication.topViewController()?.present(customAlertViewController, animated: true)
            self.customAlertViewIsVisible = true
        }
    }
}

extension NetworkCheck: CustomAlertDelegate {
    func action() {
        self.customAlertViewIsVisible = false
        self.checkNetworkAndShowAlert()
    }
    
    func exit() {
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            Darwin.exit(0)
        }
    }
}
