//
//  FirestoreManager.swift
//  Exam_Ross
//
//  Created by Ross on 2025-07-07.
//

import Foundation
import FirebaseFirestore

class FirestoreManager: ObservableObject{
    @Published var favBikes = [Bike]()
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    private let COLLECTION_BIKEDB: String = "FavouriteBikes"
    
    private let db: Firestore
    
    private static var shared: FirestoreManager?
    
    init (db: Firestore) {
        self.db = db
    }
    
    static func getInstance() -> FirestoreManager {
        if (shared == nil) {
            shared = FirestoreManager(db: Firestore.firestore())
        }
        return shared!
    }
    
    func insertFavBike(newBike: Bike) async {
        do {
            let ref = try await db
                .collection(COLLECTION_BIKEDB)
                .document(newBike.id)
                .setData(from: newBike)
            
            DispatchQueue.main.async {
                self.alertMessage = "Successfully added to favourites"
                self.showAlert = true
            }

        } catch let err as NSError {
            print("Error adding document: \(err)")
        }
    }
    
    func getAllFavBikes() async {
        do {
            let snapshot = try await db
                .collection(COLLECTION_BIKEDB)
                .getDocuments()
            
            var bikes: [Bike] = []
            
            for doc in snapshot.documents {
                do {
                    let bike = try doc.data(as: Bike.self)
                    bikes.append(bike)
                } catch {
                    print("Error decoding bike: \(error)")
                }
            }
            
            let updatedBikes = bikes
            
            DispatchQueue.main.async {
                self.favBikes = updatedBikes
            }
        } catch {
            print("Error getting documents: \(error)")
        }
    }
    
    func deleteFavBike(bikeToDelete: Bike) async {
        do {
            try await db
                .collection(COLLECTION_BIKEDB)
                .document(bikeToDelete.id)
                .delete()
            
            print("Deleted bike")
        } catch {
            print("Unable to delete bike: \(error)")
        }
    }
}
