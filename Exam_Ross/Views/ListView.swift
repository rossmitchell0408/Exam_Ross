//
//  ListView.swift
//  Exam_Ross
//
//  Created by Ross on 2025-07-07.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var bikeViewModel : BikeViewModel
    var body: some View {
        NavigationView {
            List(self.bikeViewModel.bikes) { bike in
                NavigationLink(destination: DetailView(bikeId: bike.id)) {
                    Text("City: \(bike.location.city)")
                }
                .environmentObject(bikeViewModel)
            }
        }
        .padding()
        .onAppear{
            self.bikeViewModel.fetchBikes()
        }
    }
}
