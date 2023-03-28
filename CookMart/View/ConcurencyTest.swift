//
//  ConcurencyTest.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 28/03/23.
//

import SwiftUI

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

class Cat: Decodable, ObservableObject {
    var fact: String
    var length: Int
    
    init(fact: String = "Loading....", length: Int = 10) {
        self.fact = fact
        self.length = length
    }
}

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
    }
    
    func clear() {
        cat1 = .init()
        cat2 = .init()
        activity1 = .init()
        activity2 = .init()
    }
}

struct ConcurentView: View {
    @ObservedObject var model: ConcurentModel
    
    init(model: ConcurentModel) {
        self.model = model
    }
    
    var body: some View {
        VStack {
            Picker("What is your favorite color?", selection: $model.type) {
                Text("Parallel").tag(ConcurentType.parallel)
                Text("Concurrent").tag(ConcurentType.concurent)
            }
            .pickerStyle(.segmented)
            .padding()
            List {
                Section {
                    CatView(cat: model.cat1)
                        .padding()
                    CatView(cat: model.cat2)
                        .padding()
                } header: {
                    Text("Cats")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.black)
                }
                
                Section {
                    ActivityView(activity: model.activity1)
                        .padding()
                    ActivityView(activity: model.activity2)
                        .padding()
                } header: {
                    Text("Activities")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.black)
                }
            }
            .onAppear {
                Task {
                    do {
                        try await model.start()
                    }
                }
            }
        }
    }
}

struct CatView: View {
    @ObservedObject var cat: Cat
    
    init(cat: Cat) {
        self.cat = cat
    }
    
    var body: some View {
        HStack {
            Image("cat")
                .resizable()
                .frame(width: 30, height: 30)
            VStack(alignment: .leading) {
                HStack {
                    Text("Fun fact:")
                        .bold()
                    Spacer()
                    Text(!cat.fact.contains("Loading") ? "✅" : "...")
                        .font(.title3)
                }
                Text(cat.fact)
                    .lineLimit(3)
            }
        }
    }
}

struct ActivityView: View {
    @ObservedObject var activity: Activity
    
    init(activity: Activity) {
        self.activity = activity
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text("Type:              ")
                        .font(.headline)
                        .bold()
                    Text(activity.type.uppercased())
                        .font(.headline)
                        .bold()
                    Spacer()
                    Text(!activity.type.contains("Loading") ? "✅" : "...")
                        .font(.title3)
                }
                .padding([.bottom], 4)
                HStack(alignment: .top) {
                    Text("Activity:         ")
                        .bold()
                    Text(activity.activity)
                }
                HStack(alignment: .top) {
                    Text("Participants: ")
                        .bold()
                    Image(systemName: "person.fill")
                    Text("\(activity.participants)")
                }
                HStack(alignment: .top) {
                    Text("Price:              ")
                        .bold()
                    Image(systemName: "bitcoinsign.circle.fill")
                    Text("$\(String.init(format: "%.1f", activity.price * 100.0))")
                }
            }
        }
    }
}

struct ConcurencyTest: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Parallel") {
                    ConcurentView(model: .init())
                }
                .padding()
                
                NavigationLink("Concurent") {
                    ConcurentView(model: .init())
                }
                .padding()
            }
        }
    }
}

struct ConcurencyTest_Previews: PreviewProvider {
    static var previews: some View {
        ConcurencyTest()
        ConcurentView(model: .init())
    }
}
