//
//  Module: DebugNavBar_Example
//  Created by: MrTrent on 27.08.2022
//  Copyright (c) 2022 Zordz Union
//  


import Foundation
import DebugNavBar

// Dummy VC to Test Debug VC segue.
class TestDebugVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

// DynamicDebugString_Protocol - example
extension TestDebugVC: DynamicDebugString_Protocol {
    var debugString: String {
        return "Example of Dynamic Debug String"
    }
}
