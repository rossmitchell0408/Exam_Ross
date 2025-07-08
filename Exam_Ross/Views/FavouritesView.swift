//
//  FavouritesView.swift
//  Exam_Ross
//
//  Created by Ross on 2025-07-07.
//

import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var bikeViewModel : BikeViewModel
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @State private var showDeleteAlert : Bool = false
    @State private var bikeToDelete : Bike? = nil
    
    var body: some View {
        NavigationView {
            List{
                ForEach(firestoreManager.favBikes) { bike in
                    HStack {
                        Button{
                            showDeleteAlert = true
                            bikeToDelete = bike
                        }label: {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.red)
                        }
                        .buttonStyle(.borderless)
                        Spacer()
                        NavigationLink(destination: DetailView(bikeId: bike.id)){
                            VStack{
                                Text("City: \(bike.location.city)")
                                    .fontWeight(.bold)
                                if let companies = bike.company{
                                    ForEach(companies, id: \.self){company in
                                        Text("Company: \(company)")
                                    }
                                    
                                }
                            }
                            
                        }

                    }
                    .environmentObject(bikeViewModel)
                    .environmentObject(firestoreManager)
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        showDeleteAlert = true
                        bikeToDelete = firestoreManager.favBikes[index]
                        //plantToDelete = indoorPlants[index]
                    }
                })
            }
        }
        .padding()
        .onAppear{
            //self.bikeViewModel.fetchBikes()
            Task{
                if firestoreManager.favBikes.isEmpty{
                    await firestoreManager.getAllFavBikes()
                }
            }
        }
        .alert("Are you sure you wish to remove from favourites?", isPresented: $showDeleteAlert){
            Button{
                delete()
            }label: {
                Text("Delete")
            }
            Button{
            }label: {
                Text("Cancel")
            }
        }
    }
    
    private func delete(){
        if bikeToDelete == nil{
            return
        }
        Task{
            await firestoreManager.deleteFavBike(bikeToDelete: bikeToDelete!)
            bikeToDelete = nil
            await firestoreManager.getAllFavBikes()
        }
    }
}
