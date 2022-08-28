//
//  Module: ZUCore
//  Created by: MrTrent on 21.08.2022
//  Copyright (c) 2022 Zordz Union
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
