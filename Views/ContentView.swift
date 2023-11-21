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
                Label("Acceuil", systemImage: "house.fill")
            }

            NavigationView {
                ProfilView()
            }
            .tabItem {
                Label("Page 2", systemImage: "person.fill")
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
