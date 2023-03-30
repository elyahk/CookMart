//
//  File.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 30/03/23.
//

import Foundation
class Activity: Decodable, ObservableObject {
    var activity: String
    var type: String
    var participants: Int
    var price: Double
    
    init(activity: String = "Loading...", type: String = "Loading...", participants: Int = 0, price: Double = 0.0) {
        self.activity = activity
        self.type = type
        self.participants = participants
        self.price = price
    }
}

