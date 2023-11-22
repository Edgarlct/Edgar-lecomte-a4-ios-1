//
//  CategoryViewModel.swift
//  workoutApp
//
//  Created by Edgar Lecomte on 21/11/2023.
//

import Foundation

class WorkoutViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var exercises: [WorkoutProgram] = []
    @Published var selectedCategory: Category? = nil
    
    init() {
        categories = [
            Category(name: "Cardio", imageUrl: "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg"),
            Category(name: "Strength", imageUrl: "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg"),
            Category(name: "Yoga", imageUrl: "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg"),
            Category(name: "Pilates", imageUrl: "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg")
        ]
        
        loadExercises()
    }
    
    var filteredExercises: [WorkoutProgram] {
        if let selectedCategory = selectedCategory {
            return exercises.filter { $0.category?.id == selectedCategory.id }
        }
        return exercises
    }
    
    func selectCategory(_ category: Category) {
        if selectedCategory?.id == category.id {
            // Deselect if the same category is tapped again
            selectedCategory = nil
        } else {
            selectedCategory = category
        }
    }
    
    func clearSelection() {
        selectedCategory = nil
    }
    
    // Add a new workout
    func addWorkout(_ workout: WorkoutProgram) {
        exercises.append(workout)
        saveExercises()
    }
    
    // Update an existing workout
    func updateWorkout(_ workout: WorkoutProgram) {
        if let index = exercises.firstIndex(where: { $0.id == workout.id }) {
            exercises[index] = workout
        }
        saveExercises()
    }
    
    // Delete a workout
    func deleteWorkout(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
        saveExercises()
    }
    
    private func saveExercises() {
        if let encoded = try? JSONEncoder().encode(exercises) {
            UserDefaults.standard.set(encoded, forKey: "SavedExercises")
        }
    }
    
    private func loadExercises() {
        if let savedExercises = UserDefaults.standard.object(forKey: "SavedExercises") as? Data {
            if let decodedExercises = try? JSONDecoder().decode([WorkoutProgram].self, from: savedExercises) {
                exercises = decodedExercises
                return
            }
        }
        exercises = []
    }
}
