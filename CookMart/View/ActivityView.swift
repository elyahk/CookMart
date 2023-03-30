//
//  File.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 30/03/23.
//

import Foundation
import SwiftUI

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

