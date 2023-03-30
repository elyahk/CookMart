//
//  File.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 30/03/23.
//

import SwiftUI

struct CookingStepView: View {
    @State var steps: [String]
    
    init(steps: [String]) {
        self.steps = steps
    }

    var body: some View {
            VStack(alignment: .leading) {
                ForEach(Range(1...steps.count)) { id in
                    VStack(alignment: .leading) {
                        Text("\(id). Step")
                            .font(.title3)
                            .bold()
                            .padding([.leading])
                            .padding([.bottom], 0.5)
                        HStack {
                            Text(steps[id-1])
                        }
                        .padding([.leading])
                    }
                    .padding([.top], 4)
                }
            }
        
    }
}
