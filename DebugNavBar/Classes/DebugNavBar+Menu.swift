//
//  Module: DebugNavBar
//  Created by: MrTrent on 28.08.2022
//  Copyright (c) 2022 Zordz Union
//  


import Foundation
import ZUCore

extension DebugNavBar {
    internal func addDebugMenuGesture() {
        /// add debug menu gesture
        let gesture = _Configurator.shared.debugGesture
        gesture.addTarget(self, action: #selector(tryShowDebugMenu(_:)))
        self.addGestureRecognizer(gesture)
    }
    
    @objc private func tryShowDebugMenu(_ sender: UIGestureRecognizer) {
        if sender.state == .recognized {
            if AppUtils.isDebug {
                // debug scheme
                if _Configurator.shared.menuAlwaysEnableInDebug {
                    // always avaliable
                    pushToDebugMenuVC()
                } else {
                    if _Configurator.shared.passwordIsCorrect {
                        // password already entered and correct
                        pushToDebugMenuVC()
                    } else {
                        // show alert with password entering
                        showSecurityAlert()
                    }
                }
            } else {
                // release scheme
                if _Configurator.shared.menuEnableInRelease {
                    if _Configurator.shared.passwordIsCorrect {
                        // password already entered and correct
                        pushToDebugMenuVC()
                    } else {
                        // show alert with password entering
                        showSecurityAlert()
                    }
                }
            }
        }
    }
    
    private func showSecurityAlert() {
        let alert = UIAlertController(title: "Developer Mode", message: "Enter a password", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: "Enter", style: .default, handler: { [weak alert] (_) in
            if let textField = alert?.textFields![0] {
                // check password
                let enteredPassword = textField.text ?? ""
                let successBlock = {
                    _Configurator.shared.passwordIsCorrect = true
                    self.pushToDebugMenuVC()
                }
                let errorBlock = {
                    self.showWrongPassAlert()
                }
                
                _Configurator.shared.passwordCheck_Block(enteredPassword, successBlock, errorBlock)
            }
        }))
        UIApplication.shared.topViewController?.present(alert, animated: true, completion: nil)
    }
    
    private func showWrongPassAlert() {
        let alert = UIAlertController(title: "Developer Mode", message: "Wrong password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.topViewController?.present(alert, animated: true, completion: nil)
    }
    
    private func pushToDebugMenuVC() {
        UIApplication.shared.topNavigationController?.pushViewController(_Configurator.shared.segueDestination, animated: true)
    }
}
