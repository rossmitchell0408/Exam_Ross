//
//  ListView.swift
//  Exam_Ross
//
//  Created by Ross on 2025-07-07.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var bikeViewModel : BikeViewModel
    @EnvironmentObject var firestoreManager: FirestoreManager
    var body: some View {
        NavigationView {
            List(self.bikeViewModel.bikes) { bike in
                NavigationLink(destination: DetailView(bikeId: bike.id)) {
                    Text("\(bike.location.city)")
                }
                .environmentObject(bikeViewModel)
                .environmentObject(firestoreManager)
            }
        }
        .padding()
        .onAppear{
            self.bikeViewModel.fetchBikes()
        }
    }
}
