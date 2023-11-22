//
//  CaloriesBurnedResult.swift
//  workoutApp
//
//  Created by Edgar Lecomte on 22/11/2023.
//

import Foundation

struct CaloriesBurnedResult: Codable {
    let name: String
    let calories_per_hour: Int
    let duration_minutes: Int
    let total_calories: Int
}
