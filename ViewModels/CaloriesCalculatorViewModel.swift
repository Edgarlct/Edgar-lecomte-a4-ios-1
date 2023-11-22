//
//  CaloriesCalculatorViewModel.swift
//  workoutApp
//
//  Created by Edgar Lecomte on 22/11/2023.
//

import Foundation

class CaloriesCalculatorViewModel: ObservableObject {
    @Published var sportName: String = ""
    @Published var duration: String = ""
    @Published var weight: String = ""
    @Published var results: [CaloriesBurnedResult] = []
    @Published var isLoading = false
    @Published var timeUnit: TimeUnit = .minutes
    
    enum TimeUnit: String, CaseIterable, Identifiable {
        case minutes = "Minutes"
        case hours = "Hours"
        var id: String { self.rawValue }
    }
    
    func calculateCaloriesBurned() {
        guard let weightKg = Double(weight) else {
            // Handle error - invalid weight input
            return
        }
        
        let weightInPounds = weightKg * 2.20462
        guard let duration = Int(duration) else {
            // Handle error - invalid duration input
            return
        }
        
        let durationInMinutes = timeUnit == .hours ? duration * 60 : duration
        
        
        guard let url = URL(string: "https://api.api-ninjas.com/v1/caloriesburned?activity=\(sportName)&weight=\(weightInPounds)&duration=\(durationInMinutes)") else {
            // Handle error - invalid URL
            print("Invalid URL")
            return
        }
        
        isLoading = true
        var request = URLRequest(url: url)
        request.addValue("QCp2HAzLhV8bzFYtbySd+w==keMNYrrQ962IvkkX", forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let data = data {
                    let decoder = JSONDecoder()
                    if let result = try? decoder.decode([CaloriesBurnedResult].self, from: data) {
                        self.results = result
                    }
                }
            }
        }.resume()
    }
}



