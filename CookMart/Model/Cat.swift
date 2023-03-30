//
//  File.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 30/03/23.
//

import Foundation

class Cat: Decodable, ObservableObject {
    var fact: String
    var length: Int
    
    init(fact: String = "Loading....", length: Int = 10) {
        self.fact = fact
        self.length = length
    }
}
