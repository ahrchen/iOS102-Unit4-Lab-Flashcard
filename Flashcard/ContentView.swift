//
//  ContentView.swift
//  Flashcard
//
//  Created by Raymond Chen on 7/18/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var cards: [Card] = Card.mockedCards
        
    var body: some View {
        // Card deck
        ZStack {
            ForEach(0..<cards.count, id: \.self) { index in
                CardView(card: cards[index])
                    .rotationEffect(.degrees(Double(cards.count - 1 - index) * -5))
            }
        }
    }
}

#Preview {
    ContentView()
}
