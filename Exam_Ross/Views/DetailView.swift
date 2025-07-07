//
//  DetailView.swift
//  Exam_Ross
//
//  Created by Ross on 2025-07-07.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var bikeViewModel : BikeViewModel
    let bikeId : String
    @State var bike : Bike? = nil
    
    var body: some View {
        VStack{
            if bike != nil {
                Text("Bike: \(bike!.name)")
                Text("City: \(bike!.location.city)")
                Text("Country: \(bike!.location.country)")
            }
        }
        .onAppear{
            if bikeViewModel.bikes.isEmpty{
                bikeViewModel.fetchBikes()
            }
            bike = bikeViewModel.bikes.first(where: {$0.id == bikeId}) ?? nil
        }
    }
}
