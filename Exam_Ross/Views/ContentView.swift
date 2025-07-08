//
//  ContentView.swift
//  Exam_Ross
//
//  Created by Ross on 2025-07-07.
//

import SwiftUI

struct ContentView: View {
    @StateObject var bikeViewModel = BikeViewModel()
    @StateObject var firestoreManager = FirestoreManager.getInstance()
    var body: some View {
        ListView()
            .environmentObject(bikeViewModel)
            .environmentObject(firestoreManager)
//        VStack {
//            List(self.bikeViewModel.bikes) { bike in
//                Text("Bike: \(bike.name)")
//            }
//        }
//        .padding()
//        .onAppear{
//            self.bikeViewModel.fetchBikes()
//        }
    }
}
