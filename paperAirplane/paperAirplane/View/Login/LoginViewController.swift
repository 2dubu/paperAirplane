//
//  LoginViewController.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/06/11.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradient(colors: loginGradientColor)
    }
    
    // MARK: - IBActions
    @IBAction func kakaoLoginButtonTapped(_ sender: Any) {
    }
    
    @IBAction func googleLoginButtonTapped(_ sender: Any) {
    }
    
    @IBAction func appleLoginButtonTapped(_ sender: Any) {
    }
}
