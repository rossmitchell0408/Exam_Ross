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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

