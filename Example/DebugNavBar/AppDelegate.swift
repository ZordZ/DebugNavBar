//
//  AppDelegate.swift
//  DebugNavBar
//
//  Created by MrTrent on 08/19/2022.
//  Copyright (c) 2022 MrTrent. All rights reserved.
//

import UIKit
import DebugNavBar

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /*
         You can set UINavigationBar and UINavigationBarDelegate via Storyboard(like this example) or programmatically - no big difference
         If you want use your custom UINavigationControllerDelegate and DynamicDebugString:
         You can create your custom UINavigationControllerDelegate inherited from DebugNavBarDelegate and don't forget call super func.
         or
         You can create your custom UINavigationControllerDelegate with stored instance of DebugNavBarDelegate and call namesake func from you implementation.
         */
        
        // Example of configurator
        DebugNavBar.Configurator.height = 10 // if you'll change width - you'll lose auto-width
        DebugNavBar.Configurator.alignmentMode = .center
        DebugNavBar.Configurator.fontColor = .white
        DebugNavBar.Configurator.fontSize = 8.0
        DebugNavBar.Configurator.showCondition_Block = {
            return true
        }
        DebugNavBar.Configurator.debugString_Block = {
            return "Example Configurator Test String"
        }
        // set your custom gesture
        DebugNavBar.Configurator.debugGesture_Block = {
            let longTap = UILongPressGestureRecognizer()
            longTap.minimumPressDuration = 1.0
            return longTap
        }
        // set your DebugVC
        DebugNavBar.Configurator.segueDestination_Block = {
            let vc = TestDebugVC()
            return vc
        }
        // set password check - as example you can implement password check by server
        // if pass is correct - debug menu is avaliable until restart
        DebugNavBar.Configurator.passwordCheck_Block = { (enteredPassword, success, error) in
            enteredPassword == "1234" ? success() : error()
        }
        // indicates that debug menu is always enable in debug scheme without password
        DebugNavBar.Configurator.menuAlwaysEnableInDebug = false
        // indicates that debug menu is enable in release scheme only after entering password
        DebugNavBar.Configurator.menuEnableInRelease = false
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

