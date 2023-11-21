//
//  WorkoutDetailView.swift
//  workoutApp
//
//  Created by Edgar Lecomte on 20/11/2023.
//

import SwiftUI

struct WorkoutDetailView: View {
    @State private var isEditing = false
    @ObservedObject var viewModel: WorkoutViewModel
    var workout: WorkoutProgram

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let imageUrl = URL(string: workout.image) {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            Text("Title: \(workout.title)")
                .font(.title2)

            Text("Description: \(workout.description)")
                .font(.body)

            Text("Duration: \(workout.duration) minutes")
                .font(.body)

            Spacer()
        }
        .padding()
        .navigationTitle(workout.title)
        .navigationBarItems(trailing: Button("Edit") {
            isEditing = true
        })
        .sheet(isPresented: $isEditing) {
            AddOrUpdateWorkoutView(viewModel: viewModel, workout: workout)
        }
    }
}

