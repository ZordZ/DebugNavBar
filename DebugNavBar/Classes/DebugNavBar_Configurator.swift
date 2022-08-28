//
//  DebugNavBar_Configurator.swift
//  DebugNavBar
//
//  Created by Andrew Zubarew on 19.08.2022.
//

import Foundation
import ZUCore

public protocol DebugNavBar_Configurator_Protocol {
    /// layer height
    var height: CGFloat {set get}
    /// layer width
    var width: CGFloat {set get}
    
    /// text aligment
    var alignmentMode: CATextLayerAlignmentMode {set get}
    /// text color
    var fontColor: UIColor {set get}
    /// text font size
    var fontSize: CGFloat {set get}
    
    typealias ShowCondition_Block = () -> Bool
    /// use this block to implement your custom condition to show debug string(by default showed on debug scheme)
    var showCondition_Block: ShowCondition_Block {set get}
    
    typealias DebugString_Block = () -> String
    /// use this block to implement your custom debug info - as example - VC class or url path(by default showed version)
    var debugString_Block: DebugString_Block {set get}
    
    typealias DebugGesture_Block = () -> UIGestureRecognizer
    /// use this block to setup specific gesture which grants access to debug menu
    var debugGesture_Block: DebugGesture_Block {set get}
    
    typealias SegueDestination_Block = () -> UIViewController
    /// use this block to setup your custom debug vc to push
    var segueDestination_Block: SegueDestination_Block {set get}
    
    typealias PasswordCheck_Block_Success = () -> ()
    typealias PasswordCheck_Block_Error = () -> ()
    typealias PasswordCheck_Block = (String, PasswordCheck_Block_Success, PasswordCheck_Block_Error) -> ()
    /// use this block to setup your custom password check
    var passwordCheck_Block: PasswordCheck_Block {set get}
    
    /// if true - menu is always avaliable in debug scheme without password, false - avaliable with password
    var menuAlwaysEnableInDebug: Bool {set get}
    /// if true - menu is always avaliable in release scheme only with password
    var menuEnableInRelease: Bool {set get}
}



extension DebugNavBar {
    internal final class _Configurator: DebugNavBar_Configurator_Protocol {
        static public let shared = DebugNavBar._Configurator()
        
        private init () {}
        
        /// layer height
        public var height: CGFloat = 10
        /// layer width
        public var width: CGFloat = 0
        
        /// text aligment
        public var alignmentMode: CATextLayerAlignmentMode = .center
        /// text color
        public var fontColor: UIColor = .green
        /// text font size
        public var fontSize: CGFloat = 8.0
        
        public typealias ShowCondition_Block = () -> Bool
        /// use this block to implement your custom condition to show debug string(by default showed on debug scheme)
        public var showCondition_Block: ShowCondition_Block = {
            return AppUtils.isDebug
        }
        /// return debug info string from Block
        var needShow: Bool {
            return showCondition_Block()
        }
        
        public typealias DebugString_Block = () -> String
        /// use this block to implement your custom debug info - as example - VC class or url path(by default showed version)
        public var debugString_Block: DebugString_Block = {
            let appVersion = Bundle.main.appVersion
            return "version= \(appVersion)"
        }
        /// return debug info string from Block
        var debugString: String {
            return debugString_Block()
        }
        
        public typealias DebugGesture_Block = () -> UIGestureRecognizer
        /// use this block to setup specific gesture which grants access to debug menu
        public var debugGesture_Block: DebugGesture_Block = {
            let longTap = UILongPressGestureRecognizer()
            longTap.minimumPressDuration = 1.0
            return longTap
        }
        /// return gesture from Block
        var debugGesture: UIGestureRecognizer {
            return debugGesture_Block()
        }        
        
        public typealias SegueDestination_Block = () -> UIViewController
        /// use this block to setup your custom debug vc to push
        public var segueDestination_Block: SegueDestination_Block = {
            let vc = UIViewController()
            return vc
        }
        /// return debug vc
        var segueDestination: UIViewController {
            return segueDestination_Block()
        }
        
        typealias PasswordCheck_Block_Success = () -> ()
        typealias PasswordCheck_Block_Error = () -> ()
        typealias PasswordCheck_Block = (String, PasswordCheck_Block_Success, PasswordCheck_Block_Error) -> ()
        /// use this block to setup your custom password check
        var passwordCheck_Block: PasswordCheck_Block = { (enteredPassword, success, error) in
            enteredPassword == "1234" ? success() : error()
        }
        
        // makes menu avaliable by gesture without entering password until reboot
        internal var passwordIsCorrect: Bool = false
        /// if true - menu is always avaliable in debug scheme without password, false - avaliable with password
        var menuAlwaysEnableInDebug: Bool = false
        /// if true - menu is always avaliable in release scheme only with password
        var menuEnableInRelease: Bool = false
    }
}
