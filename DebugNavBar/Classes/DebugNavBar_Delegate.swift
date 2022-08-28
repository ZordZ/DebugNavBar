//
//  Module: DebugNavBar
//  Created by: MrTrent on 27.08.2022
//  Copyright (c) 2022 Zordz Union
//  


import Foundation

/*
 To use Dynamic Debug String - just extend every VC.
 It can be usefull to show paths or some specific info.
 */
public protocol DynamicDebugString_Protocol: UIViewController {
    var debugString: String {get}
}

/*
 You can set UINavigationBar and UINavigationBarDelegate via Storyboard(like this example) or programmatically - no big difference
 If you want use your custom UINavigationControllerDelegate and DynamicDebugString:
 You can create your custom UINavigationControllerDelegate inherited from DebugNavBarDelegate and don't forget call super func.
 or
 You can create your custom UINavigationControllerDelegate with stored instance of DebugNavBarDelegate and call namesake func from you implementation.
 */
class DebugNavBarDelegate: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        let debugString = (viewController as? DynamicDebugString_Protocol)?.debugString ?? DebugNavBar._Configurator.shared.debugString
        (navigationController.navigationBar as? DebugNavBar)?.updateDebugString(debugString)
    }
}
