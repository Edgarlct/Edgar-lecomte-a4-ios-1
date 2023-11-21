//
//  HomeView.swift
//  workoutApp
//
//  Created by Edgar Lecomte on 20/11/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = WorkoutViewModel()
    @State private var showingAddWorkoutView = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack {
                Text("Workouts")
                    .font(.largeTitle) // Large title like in navigation bar
                    .fontWeight(.bold) // Bold font weight
                    .padding(.leading, 16) // Padding to align with iOS default
                
                Spacer()
                
                Button(action: { showingAddWorkoutView = true }) {
                    Image(systemName: "plus")
                        .imageScale(.large) // Ensuring the icon is large enough
                        .padding()
                }
            }
            .padding(.vertical, 10) // Adding some vertical padding
            
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.categories) { category in
                            CategoryCard(category: category, isSelected: viewModel.selectedCategory?.id == category.id,
                                         isAnySelected: viewModel.selectedCategory != nil
                            )
                            .onTapGesture {
                                viewModel.selectCategory(category)
                            }
                        }
                    }
                }.padding(.horizontal)
                if viewModel.filteredExercises.isEmpty {
                    Text("No exercises found for this category.")
                    Button("Clear Filter") {
                        viewModel.clearSelection()
                    }
                } else {
                    ForEach(viewModel.filteredExercises) { exercise in
                        NavigationLink(destination: WorkoutDetailView(viewModel: viewModel, workout: exercise)) {
                            ExerciseCard(exercise: exercise)
                                .padding(.horizontal)
                        }
                    }.onDelete(perform: viewModel.deleteWorkout)
                }
                
                
            }
        }.sheet(isPresented: $showingAddWorkoutView) {
            AddOrUpdateWorkoutView(viewModel: viewModel)
        }
    }
}

struct CategoryCard: View {
    var category: Category
    var isSelected: Bool
    var isAnySelected: Bool
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: category.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .cornerRadius(10)
            .overlay(
                // Semi-transparent black overlay for readability
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.25)
            )
            .overlay(
                Text(category.name)
                    .foregroundColor(.white)
                    .padding(.bottom, 8),
                alignment: .bottom
            )
        }
        .opacity(isAnySelected && !isSelected ? 0.7 : 1.0)
    }
}

struct ExerciseCard: View {
    var exercise: WorkoutProgram
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: exercise.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity, maxHeight: 150) // Full width and fixed height
            .cornerRadius(10)
            .overlay(
                // Semi-transparent black overlay for readability
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.25)
            )
            .overlay(
                VStack {
                    Spacer()
                    Text(exercise.title)
                        .foregroundColor(.white)
                        .padding()
                }
            )
        }
        .frame(maxWidth: .infinity, idealHeight: 150)
    }
}
