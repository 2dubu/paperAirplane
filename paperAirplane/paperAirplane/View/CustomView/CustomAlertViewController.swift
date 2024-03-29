//
//  CustomAlertViewController.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/05/26.
//

import Foundation
import UIKit

/// Custom Alert의 버튼의 액션을 처리하는 Delegate입니다.
protocol CustomAlertDelegate {
    func action()   // confirm button event
    func exit()     // cancel button event
}

extension CustomAlertDelegate where Self: UIViewController {
    func show(
        alertType: AlertType,
        alertText: String,
        cancelButtonText: String? = "",
        confirmButtonText: String
    ) {
        
        let customAlertStoryboard = UIStoryboard(name: "CustomAlertViewController", bundle: nil)
        let customAlertViewController = customAlertStoryboard.instantiateViewController(withIdentifier: "CustomAlertViewController") as! CustomAlertViewController
        
        customAlertViewController.delegate = self
        
        customAlertViewController.modalPresentationStyle = .overFullScreen
        customAlertViewController.modalTransitionStyle = .crossDissolve
        customAlertViewController.alertText = alertText
        customAlertViewController.alertType = alertType
        customAlertViewController.cancelButtonText = cancelButtonText ?? ""
        customAlertViewController.confirmButtonText = confirmButtonText
        
        self.present(customAlertViewController, animated: true, completion: nil)
    }
}

enum AlertType {
    case onlyConfirm    // 확인 버튼
    case canCancel      // 확인 + 취소 버튼
}

class CustomAlertViewController: UIViewController {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    var alertType: AlertType = .onlyConfirm
    
    var delegate: CustomAlertDelegate?
    
    var alertText = ""
    var cancelButtonText = ""
    var confirmButtonText = ""
    var confirmButtonCompletionClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // customAlertView 기본 세팅
        setCustomAlertView()
        
        switch alertType {
        case .onlyConfirm:
            
            cancelButton.isHidden = true
            
            confirmButton.isHidden = false
            confirmButton.setTitle(confirmButtonText, for: .normal)
            confirmButton.widthAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: 1).isActive = true
            
        case .canCancel:
            
            cancelButton.isHidden = false
            cancelButton.setTitle(cancelButtonText, for: .normal)
            
            confirmButton.isHidden = false
            confirmButton.setTitle(confirmButtonText, for: .normal)
            confirmButton.layer.maskedCorners = CACornerMask.layerMaxXMaxYCorner
            confirmButton.widthAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: 0.5).isActive = true
        }
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.action()
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.exit()
        }
    }
    
    private func setCustomAlertView() {
        
        /// customAlertView 둥글기 적용
        alertView.layer.cornerRadius = 20
        
        /// alert 내용 폰트 설정
        textLabel.text = alertText
        textLabel.textColor = alertTextColor
        
        /// 취소 버튼 둥글기 적용 및 폰트 설정
        cancelButton.backgroundColor = cancelButtonColor
        cancelButton.layer.cornerRadius = 20
        cancelButton.layer.maskedCorners = CACornerMask.layerMinXMaxYCorner
        cancelButton.titleLabel?.textColor = alertTextColor
        
        /// 확인 버튼 둥글기 적용 및 폰트 설정
        confirmButton.backgroundColor = confirmButtonColor
        confirmButton.layer.cornerRadius = 20
        confirmButton.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        confirmButton.titleLabel?.textColor = alertTextColor
    }
}
