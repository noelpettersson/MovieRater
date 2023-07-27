//
//  MovieRaterApp.swift
//  MovieRater
//
//  Created by Anders Pettersson on 2023-07-27.
//

import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct MovieRaterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            //If logged in go to MainView else go to LoginView
            if(Auth.auth().currentUser != nil) {
                MainView()
            } else {
                RegisterView()
            }
        }
    }
}
