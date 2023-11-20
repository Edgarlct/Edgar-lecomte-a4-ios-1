//
//  WorkoutsListView.swift
//  workoutApp
//
//  Created by Edgar Lecomte on 20/11/2023.
//

import SwiftUI

struct WorkoutsListView: View {
    @StateObject var viewModel = WorkoutProgramViewModel()
    @State private var showingAddWorkoutView = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Your Workouts")
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
            .background(Color(UIColor.systemBackground)) // Match the background color with the system background

            List(viewModel.workouts) { workout in
                NavigationLink(destination: WorkoutDetailView(viewModel: viewModel, workout: workout)) {
                    HStack {
                        if let imageUrl = URL(string: workout.image) {
                            AsyncImage(url: imageUrl) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        }

                        VStack(alignment: .leading) {
                            Text(workout.title)
                                .font(.headline)
                            Text("\(workout.duration) min")
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddWorkoutView) {
            AddOrUpdateWorkoutView(viewModel: viewModel)
        }
    }
}

struct WorkoutsListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .accentColor(.white) // Color for the tab items
            .preferredColorScheme(.dark)
    }
}

