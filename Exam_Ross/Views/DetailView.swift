//
//  DetailView.swift
//  Exam_Ross
//
//  Created by Ross on 2025-07-07.
//

import SwiftUI
import MapKit

struct DetailView: View {
    @EnvironmentObject var bikeViewModel : BikeViewModel
    @EnvironmentObject var firestoreManager: FirestoreManager
    let bikeId : String
    @State private var bike : Bike? = nil
    @State private var isFav : Bool = false
    @State private var region = MKCoordinateRegion()
    
    var body: some View {
        VStack{
            if bike != nil {
                Text("\(bike!.name)")
                    .font(.title)
                    
                Map(coordinateRegion: $region, annotationItems: [bike!]) { bike in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: bike.location.latitude, longitude: bike.location.longitude)){
                        VStack{
                            Text(bike.location.city)
                                .font(.caption)
                                .padding(4)
                                .background(Color.white)
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
                .frame(height: 300)
                Text("Location: \(bike!.location.city), \(bike!.location.country)")
                    .font(.title2)
                if let companies = bike!.company{
                    Text("Companies:")
                    ForEach(companies, id: \.self){company in
                        Text("\(company)")
                    }
                }
                Spacer()
                Button{
                    toggleFavourite()
                }label: {
                    Image(systemName: isFav == true ? "heart.fill" : "heart")
                        .font(.title)
                        .foregroundStyle(.red)
                }
            }
        }
        .padding()
        .alert("\(firestoreManager.alertMessage)", isPresented: $firestoreManager.showAlert){
            Button{
                firestoreManager.alertMessage = ""
            }label: {
                Text("Dismiss")
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
            region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: bike!.location.latitude, longitude: bike!.location.longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
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




