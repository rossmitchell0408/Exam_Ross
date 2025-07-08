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
    @State private var selectedTab: Int = 0

    var body: some View {
        NavigationStack{
            TabView(selection: $selectedTab){
                ListView()
                    .tabItem{
                        Label("All", systemImage: "list.bullet")
                    }
                    .tag(0)
                FavouritesView()
                    .tabItem{
                        Label("Favs", systemImage: "heart.circle.fill")
                    }
                    .tag(1)
            }
        }
        .environmentObject(bikeViewModel)
        .environmentObject(firestoreManager)
    }
}
