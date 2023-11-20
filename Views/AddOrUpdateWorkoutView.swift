//
//  AddOrUpdateWorkoutView.swift
//  workoutApp
//
//  Created by Edgar Lecomte on 20/11/2023.
//

import SwiftUI

struct AddOrUpdateWorkoutView: View {
    @ObservedObject var viewModel: WorkoutProgramViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var workout: WorkoutProgram
    @State private var isNewWorkout: Bool

    init(viewModel: WorkoutProgramViewModel, workout: WorkoutProgram? = nil) {
        self.viewModel = viewModel
        if let workout = workout {
            self._workout = State(initialValue: workout)
            self._isNewWorkout = State(initialValue: false)
        } else {
            self._workout = State(initialValue: WorkoutProgram(image: "", title: "", description: "", duration: 0))
            self._isNewWorkout = State(initialValue: true)
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Workout Details")) {
                    TextField("Title", text: $workout.title)
                    TextField("Description", text: $workout.description)
                    TextField("Duration (in minutes)", value: $workout.duration, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    TextField("Image URL", text: $workout.image)
                }

                Section {
                    Button(isNewWorkout ? "Add Workout" : "Update Workout") {
                        saveWorkout()
                    }
                }
            }
            .navigationTitle(isNewWorkout ? "Add Workout" : "Edit Workout")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private func saveWorkout() {
        if isNewWorkout {
            viewModel.addWorkout(workout)
        } else {
            viewModel.updateWorkout(workout)
        }
        presentationMode.wrappedValue.dismiss()
    }
}
