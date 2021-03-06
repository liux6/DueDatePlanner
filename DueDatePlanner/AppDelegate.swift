//
//  AppDelegate.swift
//  DueDatePlanner
//
//  Created by Xusheng Liu on 5/6/20.
//  Copyright © 2020 Rose-Hulman. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return (GIDSignIn.sharedInstance()?.handle(url))!
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Error with Google Auth! Error: \(error.localizedDescription)")
            return
        }
        print("You are signed in using Google account: \(user.profile.email!)")
        //        guard let authentication = user.authentication else { return }
        //        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
        //                                                       accessToken: authentication.accessToken)
        _ = user.userID
        _ = user.authentication.idToken
        let fullName = user.profile.name!
        _ = user.profile.givenName
        _ = user.profile.familyName
        let email = user.profile.email!
        print("Name \(fullName) Email \(email)")
        
        guard let authentication = user.authentication else { return }
        let googleCredential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        // Use the google sign in credential to sign in with firebase
        Auth.auth().signIn(with: googleCredential) { (authResult, error) in
            if let error = error {
                print("Firebase sign in error from Google! \(error)")
                return
            }
            let loginVc = GIDSignIn.sharedInstance()?.presentingViewController as! LoginViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            loginVc.view.window!.rootViewController = storyboard.instantiateViewController(withIdentifier: "NavViewController")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operation when user disconnect
        // ...
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
