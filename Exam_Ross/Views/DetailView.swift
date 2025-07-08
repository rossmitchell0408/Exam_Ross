//
//  DetailView.swift
//  Exam_Ross
//
//  Created by Ross on 2025-07-07.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var bikeViewModel : BikeViewModel
    @EnvironmentObject var firestoreManager: FirestoreManager
    let bikeId : String
    @State var bike : Bike? = nil
    @State var isFav : Bool = false
    
    var body: some View {
        VStack{
            if bike != nil {
                Text("Bike: \(bike!.name)")
                Text("City: \(bike!.location.city)")
                Text("Country: \(bike!.location.country)")
                Button{
                    toggleFavourite()
                }label: {
                    Image(systemName: isFav == true ? "heart.fill" : "heart")
                }
            }
        }
        .onAppear{
            if bikeViewModel.bikes.isEmpty{
                bikeViewModel.fetchBikes()
            }
            bike = bikeViewModel.bikes.first(where: {$0.id == bikeId}) ?? nil
            Task{
                if firestoreManager.favBikes.isEmpty{
                    await firestoreManager.getAllFavBikes()
                }
                checkIsFav()
            }
            
        }
    }
    
    private func toggleFavourite(){
        if bike == nil{
            return
        }
        Task{
            if isFav{
                await firestoreManager.deleteFavBike(bikeToDelete: bike!)
                isFav = false
            }else{
                await firestoreManager.insertFavBike(newBike: bike!)
                isFav = true
            }
            await firestoreManager.getAllFavBikes()
        }
    }
    
    private func checkIsFav(){
        if bike == nil{
            return
        }
        
        if firestoreManager.favBikes.contains(where: { $0.id == self.bike!.id }){
            isFav = true
        }else{
            isFav = false
        }
    }
}
