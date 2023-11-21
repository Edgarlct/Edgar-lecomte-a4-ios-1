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
        exercises = [
            WorkoutProgram(image:"https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg", title: "pilat", description: "test", duration: 10, category: categories[0]),
            WorkoutProgram(image:"https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg", title: "pilat1", description: "test", duration: 10, category: categories[1]),
            WorkoutProgram(image:"https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg", title: "pilat3", description: "test", duration: 10, category: categories[2])
        ]
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
    }
    
    // Update an existing workout
    func updateWorkout(_ workout: WorkoutProgram) {
        if let index = exercises.firstIndex(where: { $0.id == workout.id }) {
            exercises[index] = workout
        }
    }
    
    // Delete a workout
    func deleteWorkout(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }
}
