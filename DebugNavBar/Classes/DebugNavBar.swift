//
//  DebugNavBar.swift
//  DebugNavBar
//
//  Created by Andrew Zubarew on 19.08.2022.
//

import Foundation
import UIKit
import ZUCore

open class DebugNavBar: UINavigationBar {
    /// access to configurator
    static public var Configurator: DebugNavBar_Configurator_Protocol = _Configurator.shared
    
    // used to show some debug info
    var textLayer: CATextLayer?
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        addDebugInfoLayer()
    }
    
    private func addDebugInfoLayer() {
        // first setup
        if textLayer == nil {
            let textLayer = CATextLayer()
            self.textLayer = textLayer
            // set frame
            updateDebugInfoLayerFrame()
            // configure
            configureDebugInfoLayer()
            // add layer
            self.layer.addSublayer(textLayer)
        }
        // correcting frame
        updateDebugInfoLayerFrame()
        // show/hide
        textLayer?.isHidden = !_Configurator.shared.needShow || !_Configurator.shared.passwordIsCorrect
    }
    
    private func updateDebugInfoLayerFrame() {
        let offset: CGFloat = 8
        let x = DebugNavBar.Configurator.width == 0 ? offset : frame.width - DebugNavBar.Configurator.width
        let width = DebugNavBar.Configurator.width == 0 ? frame.width - 2*offset : DebugNavBar.Configurator.width
        textLayer?.frame = CGRect(x: x,
                                  y: frame.height - DebugNavBar.Configurator.height,
                                  width: width,
                                  height: DebugNavBar.Configurator.height)
    }
    
    private func configureDebugInfoLayer() {
        // common params
        textLayer?.fontSize = DebugNavBar.Configurator.fontSize
        textLayer?.alignmentMode = DebugNavBar.Configurator.alignmentMode
        textLayer?.foregroundColor = DebugNavBar.Configurator.fontColor.cgColor
        textLayer?.contentsScale = UIScreen.main.scale
        // generate debug string
        textLayer?.string = _Configurator.shared.debugString
    }
    
    open func updateDebugString(_ debugString: String) {
        self.textLayer?.string = debugString
    }
    
    open override func didMoveToSuperview() {
        if superview != nil {
            /// add debug menu gesture
            addDebugMenuGesture()
        }
    }
}
