//
//  CustomAlertViewController.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/05/26.
//

import Foundation
import UIKit

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
    
    var alertText = ""
    var cancelButtonName = ""
    var confirmButtonName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = alertText
        
        switch alertType {
        case .onlyConfirm:
            
            confirmButton.setTitle(confirmButtonName, for: .normal)
            cancelButton.isHidden = true
            confirmButton.isHidden = false
            
        case .canCancel:
            
            cancelButton.setTitle(cancelButtonName, for: .normal)
            confirmButton.setTitle(confirmButtonName, for: .normal)
            cancelButton.isHidden = false
            confirmButton.isHidden = false
            
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func setCustomAlertView() {
        alertView.layer.cornerRadius = 20
        // cancelButton.layer.cornerRadius = 20
        // confirmButton.layer.cornerRadius = 20
    }
}
