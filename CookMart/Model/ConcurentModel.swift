//
//  File.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 30/03/23.
//

import Foundation
import SwiftUI

enum ConcurentType {
    case concurent
    case parallel
}

class ConcurentModel: ObservableObject {
    @Published var cat1: Cat = .init()
    @Published var cat2: Cat = .init()
    @Published var activity1: Activity = .init()
    @Published var activity2: Activity = .init()
    @Published var type: ConcurentType = .parallel {
        didSet {
            Task {
                do {
                    try await start()
                }
            }
        }
    }
    
    func start() async throws {
        clear()
        switch type {
        case .concurent:
            await withThrowingTaskGroup(of: Void.self) { group in
                group.addTask(priority: .background) {
                    self.cat1 = try await fetchCatRequest()
                }
                group.addTask {
                    self.cat2 = try await fetchCatRequest()
                }
                group.addTask {
                    self.activity1 = try await fetchActivityRequest()
                }
                group.addTask {
                    self.activity2 = try await fetchActivityRequest()
                }
            }
            
        case .parallel:
            self.cat1 = try await fetchCatRequest()
            self.cat2 = try await fetchCatRequest()
            self.activity1 = try await fetchActivityRequest()
            self.activity2 = try await fetchActivityRequest()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            Task {
                do {
                    self.clear()
                    try await self.start()
                }
            }
        }
    }
    
    func clear() {
        cat1 = .init()
        cat2 = .init()
        activity1 = .init()
        activity2 = .init()
    }
}

