//
//  WorkoutProgram.swift
//  workoutApp
//
//  Created by Edgar Lecomte on 20/11/2023.
//
import Foundation

struct WorkoutProgram: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var description: String
    var duration: Int // Duration in minutes
}

