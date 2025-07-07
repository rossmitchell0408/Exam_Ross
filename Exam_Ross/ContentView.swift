//
//  ContentView.swift
//  Exam_Ross
//
//  Created by Ross on 2025-07-07.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var bikeViewModel = BikeViewModel()
    var body: some View {
        VStack {
            List(self.bikeViewModel.bikes) { bike in
                Text("Bike: \(bike.name)")
            }
        }
        .padding()
        .onAppear{
            self.bikeViewModel.fetchBikes()
        }
    }
}
