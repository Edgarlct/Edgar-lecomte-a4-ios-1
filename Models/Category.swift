//
//  Category.swift
//  workoutApp
//
//  Created by Edgar Lecomte on 21/11/2023.
//

import Foundation

struct Category: Identifiable, Codable {
    let id: UUID = UUID()
    let name: String
    let imageUrl: String // URL for background image
    
}
