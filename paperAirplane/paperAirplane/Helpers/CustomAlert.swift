//
//  CustomAlert.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/05/21.
//

import Foundation
import UIKit

class CustomAlert {
    
    static let shared = CustomAlert()
    let window = UIApplication.shared.windows.first { $0.isKeyWindow }
    
    public func showAlert(vc: UIViewController, alertType: AlertType, alertText: String, cancelButtonText: String?, confirmButtonText: String, _ completion: @escaping () -> Void){
        
        if let rootVc = window?.rootViewController{
            
            let visibleController = self.getRootViewController(vc: rootVc)
            let customAlertStoryboard = UIStoryboard(name: "CustomAlertViewController", bundle: nil)
            let customAlertViewController = customAlertStoryboard.instantiateViewController(withIdentifier: "CustomAlertViewController") as! CustomAlertViewController
            
            customAlertViewController.modalPresentationStyle = .overCurrentContext
            customAlertViewController.alertText = alertText
            customAlertViewController.alertType = alertType
            customAlertViewController.cancelButtonName = cancelButtonText ?? ""
            customAlertViewController.confirmButtonName = confirmButtonText
            customAlertViewController.confirmButtonCompletionClosure = completion
            
            visibleController?.present(customAlertViewController, animated: true, completion: nil)
        }
    }
    
    public func getRootViewController(vc: UIViewController) ->UIViewController?{
        
        if let nc = vc as? UINavigationController {
            
            if let vcOfnavController = nc.visibleViewController {
                return self.getRootViewController(vc: vcOfnavController)
            }
            
        }else if let tc = vc as? UITabBarController {
            
            if let tcOfnavControler = tc.selectedViewController {
                return self.getRootViewController(vc: tcOfnavControler)
            }
            
        }else{
            if let pvc = vc.presentedViewController{
                return self.getRootViewController(vc: pvc)
            }else {
                return vc
            }
        }
        return nil
    }
}
