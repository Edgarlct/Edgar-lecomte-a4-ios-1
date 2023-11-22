//
//  WorkoutProgram.swift
//  workoutApp
//
//  Created by Edgar Lecomte on 20/11/2023.
//
import Foundation

struct WorkoutProgram: Identifiable, Codable {
    var id = UUID()
    var image: String // is an url
    var title: String
    var description: String
    var duration: Int // Duration in minutes
    var category: Category?
}

