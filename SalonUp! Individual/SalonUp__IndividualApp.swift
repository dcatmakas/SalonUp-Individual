//
//  SalonUp__IndividualApp.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 16.05.2023.
//

import SwiftUI
import CoreLocation
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      CLLocationManager().requestWhenInUseAuthorization()
      FirebaseApp.configure()
    return true
  }
}

@main
struct SalonUp__IndividualApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
