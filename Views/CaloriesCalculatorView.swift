//
//  ProfilView.swift
//  workoutApp
//
//  Created by Edgar Lecomte on 20/11/2023.
//

import SwiftUI

struct CaloriesCalculatorView: View {
    @ObservedObject var viewModel = CaloriesCalculatorViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Calculator")
                    .font(.largeTitle) // Large title like in navigation bar
                    .fontWeight(.bold) // Bold font weight
                    .padding(.leading, 16) // Padding to align with iOS default
                Spacer()
            }
            Form {
                Section(header: Text("Enter your details")) {
                    TextField("Sport Name", text: $viewModel.sportName)
                    TextField("Duration", text: $viewModel.duration)
                        .keyboardType(.numberPad)
                    
                    Picker("Time Unit", selection: $viewModel.timeUnit) {
                        ForEach(CaloriesCalculatorViewModel.TimeUnit.allCases) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    TextField("Weight (kg)", text: $viewModel.weight)
                        .keyboardType(.decimalPad)
                }
                
                Button("Calculate") {
                    viewModel.calculateCaloriesBurned()
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }
                
                ForEach(viewModel.results, id: \.name) { result in
                    Text("\(result.name): \(result.total_calories) calories \(result.calories_per_hour) / hour")
                }
            }
        }
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        CaloriesCalculatorView()
    }
}
