//
//  ContentView.swift
//  workoutApp
//
//  Created by Edgar Lecomte on 20/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Label("Page 1", systemImage: "house.fill")
            }

            NavigationView {
                ProfilView()
            }
            .tabItem {
                Label("Page 2", systemImage: "person.fill")
            }

            // List program
            NavigationView {
                WorkoutsListView()
            }
            .tabItem {
                Label("Program", systemImage: "figure.core.training")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .accentColor(.white) // Color for the tab items
            .preferredColorScheme(.dark)
    }
}
