//
//  WorkoutProgramViewModel.swift
//  workoutApp
//
//  Created by Edgar Lecomte on 20/11/2023.
//

import Foundation

class WorkoutProgramViewModel: ObservableObject {
    @Published var workouts: [WorkoutProgram] = []

    // Add a new workout
    func addWorkout(_ workout: WorkoutProgram) {
        workouts.append(workout)
    }

    // Update an existing workout
    func updateWorkout(_ workout: WorkoutProgram) {
        if let index = workouts.firstIndex(where: { $0.id == workout.id }) {
            workouts[index] = workout
        }
    }
}
