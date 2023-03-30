//
//  File.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 30/03/23.
//

import Foundation

func fetchCatRequest() async throws -> Cat {
    let url = URL(string: "https://catfact.ninja/fact")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let cat = try JSONDecoder().decode(Cat.self, from: data)
    
    return cat
}

func fetchActivityRequest() async throws -> Activity {
    let url = URL(string: "https://www.boredapi.com/api/activity")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let activity = try JSONDecoder().decode(Activity.self, from: data)
    
    return activity
}
