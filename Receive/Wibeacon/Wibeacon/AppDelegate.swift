//
//  AppDelegate.swift
//  Wibeacon
//
//  Created by NaXin on 2019/10/28.
//  Copyright © 2019年 NaXin. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let logFilePath = NSHomeDirectory() + "/Documents/BeaconLog.txt"
    let uuidFilePath = NSHomeDirectory() + "/Documents/SavedUUID.plist"
    var uuidDict = [String: String]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loadUUID()
        forceCreate(file_path: logFilePath)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        writeUUID()
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func loadUUID() {
        let fileManager: FileManager = FileManager.default
        let exist = fileManager.fileExists(atPath: uuidFilePath)
        if (!exist) {
            fileManager.createFile(atPath: uuidFilePath, contents: nil, attributes: nil)
        }
        if let dict = NSDictionary(contentsOfFile: uuidFilePath) {
            for (key, val) in dict {
                if let name = key as? String, let uuid_str = val as? String {
                    uuidDict.updateValue(uuid_str, forKey: name)
                }
            }
        }
    }
    
    func writeUUID(){
        let nsdict = NSDictionary(dictionary: uuidDict)
        nsdict.write(toFile: uuidFilePath, atomically: true)
    }
    
    func forceCreate(file_path: String) -> Bool {
        let fileManager: FileManager = FileManager.default
        let exist = fileManager.fileExists(atPath: file_path)
        if (exist) {
            try! fileManager.removeItem(atPath: file_path)
        }
        let createSuccess = fileManager.createFile(atPath: file_path, contents: nil, attributes: nil)
        return createSuccess as Bool
    }

}

