//
//  Exam_RossApp.swift
//  Exam_Ross
//
//  Created by Ross on 2025-07-07.
//

import SwiftUI
import FirebaseCore

@main
struct Exam_RossApp: App {
    init(){
        FirebaseApp.configure()
    }
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}

