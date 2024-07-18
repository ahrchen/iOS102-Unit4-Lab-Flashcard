//
//  ContentView.swift
//  Flashcard
//
//  Created by Raymond Chen on 7/18/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "dog")
                .imageScale(.large)
                .foregroundStyle(.pink)
            Text("Hello, dogs!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
