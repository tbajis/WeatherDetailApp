//
//  AppDelegate.swift
//  WeatherDetailApp
//
//  Created by Thomas Manos Bajis on 5/14/19.
//  Copyright © 2019 Thomas Manos Bajis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var controller: UIViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        // MARK: - BONUS CHALLENGE HIT THE API:
        let client = DarkSkyNetworkClient(apiKey: DarkSkyNetworkConstants.ApiKey)
        
        // Create a fake location for our model to make use of
        // NOTE: This would likely be provided by another component in our App
        let location = (lat: "39.0840", lon: "-77.1528")
        
        // Step 1: Create a Model
        let model = WeatherDetailModel(location: location,
                                       client: client)
        
        // Step 2: Create a ViewModel and set on Model
        let viewModel = WeatherDetailViewModel()
        viewModel.model = model
        
        // Step 3: Create a View (In this case, an instance of UIViewController)
        let vc = WeatherDetailViewController.instantiate(viewModel: viewModel)
        controller = vc
        
        // NOTE: We set our controller to be the root of our window
        window?.rootViewController = vc
        
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
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

