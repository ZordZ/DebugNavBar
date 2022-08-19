//
//  Bundle_Ext.swift
//  DebugNavBar
//
//  Created by Andrew Zubarew on 19.08.2022.
//

import Foundation

extension Bundle {
    var displayName: String {
        return (object(forInfoDictionaryKey: "CFBundleDisplayName") ?? object(forInfoDictionaryKey: "CFBundleName")) as? String ?? "unknown"
    }
    var appVersion: String {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "unknown"
    }
    var buildVersion: String {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "unknown"
    }
    var targetName: String? {
        return object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}
