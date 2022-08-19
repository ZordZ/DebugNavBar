//
//  DebugNavBar_Configurator.swift
//  DebugNavBar
//
//  Created by Andrew Zubarew on 19.08.2022.
//

import Foundation

public protocol DebugNavBar_Protocol {
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
    
    typealias ShowCondition = () -> Bool
    /// use this block to implement your custom condition to show debug string(by default showed on debug scheme)
    var needShow: ShowCondition {set get}
    
    typealias DebugString = () -> String
    /// use this block to implement your custom debug info - as example - VC class or url path(by default showed version)
    var debugString: DebugString {set get}
    
    
    typealias DebugGestureInitializer = () -> UIGestureRecognizer
    /// use this block to setup specific gesture which grants access to debug menu
    var debugGestureInitializer: DebugGestureInitializer {set get}
}



extension DebugNavBar {
    internal final class _Configurator: DebugNavBar_Protocol {
        static public let shared = DebugNavBar._Configurator()
        
        private init () {}
        
        /// layer height
        public var height: CGFloat = 10
        /// layer width
        public var width: CGFloat = UIScreen.main.bounds.width
        
        /// text aligment
        public var alignmentMode: CATextLayerAlignmentMode = .center
        /// text color
        public var fontColor: UIColor = .green
        /// text font size
        public var fontSize: CGFloat = 8.0
        
        public typealias ShowCondition = () -> Bool
        /// use this block to implement your custom condition to show debug string(by default showed on debug scheme)
        public var needShow: ShowCondition = {
            return AppUtils.isDebug
        }
        
        public typealias DebugString = () -> String
        /// use this block to implement your custom debug info - as example - VC class or url path(by default showed version)
        public var debugString: DebugString = {
            let appVersion = Bundle.main.appVersion
            return "version= \(appVersion)"
        }
        
        
        public typealias DebugGestureInitializer = () -> UIGestureRecognizer
        /// use this block to setup specific gesture which grants access to debug menu
        public var debugGestureInitializer: DebugGestureInitializer = {
            let longTap = UILongPressGestureRecognizer()
            longTap.minimumPressDuration = 1.0
            return longTap
        }
    }
}
