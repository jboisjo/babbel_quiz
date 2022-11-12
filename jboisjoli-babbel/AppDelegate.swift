//
//  AppDelegate.swift
//  jboisjoli-babbel
//
//  Created by Jay Boisjoli on 2022-11-11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appRouter: AppRouter?
    var window: UIWindow?
    var application: UIApplication?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // create the main navigation controller to be used for our app
        let navController = UINavigationController()
        self.application = application

        // send that into our appRouter so that it can display view controllers
        appRouter = AppRouter(navigationController: navController)

        // create a basic UIWindow and activate it
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        appRouter?.openOverview()
        
        return true
    }
}

