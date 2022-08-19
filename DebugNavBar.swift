//
//  DebugNavBar.swift
//  DebugNavBar
//
//  Created by Andrew Zubarew on 19.08.2022.
//

import Foundation
import UIKit

open class DebugNavBar: UINavigationBar {
    /// access to configurator
    static public var Configurator: DebugNavBar_Protocol = _Configurator.shared
    
    // used to show some debug info
    var textLayer: CATextLayer?
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        addDebugInfoLayer()
    }
    
    private func addDebugInfoLayer() {
        textLayer?.removeFromSuperlayer()
        // show debug layer only if we need it
        if DebugNavBar.Configurator.needShow() {
            let textLayer = CATextLayer()
            // set frame
            textLayer.frame = CGRect(x: frame.width - DebugNavBar.Configurator.width,
                                     y: frame.height - DebugNavBar.Configurator.height,
                                     width: DebugNavBar.Configurator.width,
                                     height: DebugNavBar.Configurator.height)
            // configure
            textLayer.fontSize = DebugNavBar.Configurator.fontSize
            textLayer.alignmentMode = DebugNavBar.Configurator.alignmentMode
            textLayer.foregroundColor = DebugNavBar.Configurator.fontColor.cgColor
            textLayer.contentsScale = UIScreen.main.scale
            // generate debug string
            textLayer.string = DebugNavBar.Configurator.debugString()
            // add layer
            self.layer.addSublayer(textLayer)
            self.textLayer = textLayer
        }
    }
    
    open override func didMoveToSuperview() {
        if superview != nil {
            /// add debug menu gesture
            let gesture = DebugNavBar.Configurator.debugGestureInitializer()
            gesture.addTarget(self, action: #selector(showDebugMenu(_:)))
            self.addGestureRecognizer(gesture)
        }
    }
    
    @objc private func showDebugMenu(_ sender: UIGestureRecognizer) {
        if sender.state == .recognized {
            print("!!!")
        }
    }
}
