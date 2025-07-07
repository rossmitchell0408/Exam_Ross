//
//  BikeViewModel.swift
//  Exam_Ross
//
//  Created by Ross on 2025-07-07.
//

import Foundation
//import Alamofire

class BikeViewModel: ObservableObject {
    @Published var bikes: [Bike] = []
    
    func fetchBikes() {
        let url = URL(string: "https://api.citybik.es/v2/networks")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let err = error {
                print("Error fetching bikes: \(err.localizedDescription)")
                return
            }
            
            guard let localData = data else {
                print("Bike data is empty")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(BikeResponse.self, from: localData)
                DispatchQueue.main.async {
                    self.bikes = decodedData.networks
                }
            } catch let jsonError {
                print("Failed to decode bike \(jsonError)")
            }
        }
        
        task.resume()
    }
}
