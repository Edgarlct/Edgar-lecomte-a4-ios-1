//
//  AddOrUpdateWorkoutView.swift
//  workoutApp
//
//  Created by Edgar Lecomte on 20/11/2023.
//
import SwiftUI

struct AddOrUpdateWorkoutView: View {
    @ObservedObject var viewModel: WorkoutViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var workout: WorkoutProgram
    @State private var isNewWorkout: Bool
    @State private var selectedCategoryId: UUID?

    init(viewModel: WorkoutViewModel, workout: WorkoutProgram? = nil) {
        self.viewModel = viewModel
        if let workout = workout {
            self._workout = State(initialValue: workout)
            self._isNewWorkout = State(initialValue: false)
            self._selectedCategoryId = State(initialValue: workout.category?.id)
        } else {
            self._workout = State(initialValue: WorkoutProgram(image: "", title: "", description: "", duration: 0, category: nil))
            self._isNewWorkout = State(initialValue: true)
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Workout Details")) {
                    TextField("Title", text: $workout.title)
                    
                    TextField("Image", text: $workout.image)

                    TextEditor(text: $workout.description)
                        .frame(height: 100) // Adjust height as needed

                    Picker("Category", selection: $selectedCategoryId) {
                        ForEach(viewModel.categories, id: \.id) { category in
                            Text(category.name).tag(category.id as UUID?)
                        }
                    }

                    Stepper("Duration: \(workout.duration) min", value: $workout.duration, in: 0...120) // Range duration
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
        if let selectedId = selectedCategoryId {
            workout.category = viewModel.categories.first { $0.id == selectedId }
        }

        if isNewWorkout {
            viewModel.addWorkout(workout)
        } else {
            viewModel.updateWorkout(workout)
        }
        presentationMode.wrappedValue.dismiss()
    }
}

