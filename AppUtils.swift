//
//  AppUtils.swift
//  DebugNavBar
//
//  Created by Andrew Zubarew on 19.08.2022.
//

import Foundation

public struct AppUtils {
    public static var isDebug: Bool {
        #if IS_DEBUG_MODE
            return true
        #else
            return false
        #endif
    }
}
