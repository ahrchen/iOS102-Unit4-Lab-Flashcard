//
//  ContentView.swift
//  Flashcard
//
//  Created by Raymond Chen on 7/18/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var deckId: Int = 0
    @State private var cards: [Card] = Card.mockedCards
    
    @State private var cardsToPractice: [Card] = []
    @State private var cardsMemorized: [Card] = []
    
    var body: some View {
        // Card deck
        ZStack {
            
            // Reset buttons
                VStack { // <-- VStack to show buttons arranged vertically behind the cards
                   Button("Reset") {
                       cards = cardsToPractice + cardsMemorized
                       cardsToPractice = []
                       cardsMemorized = []
                       deckId += 1
                   }
                   .disabled(cardsToPractice.isEmpty && cardsMemorized.isEmpty)

                   Button("More Practice") {
                       cards = cardsToPractice
                       cardsToPractice = []
                       deckId += 1
                   }
                   .disabled(cardsToPractice.isEmpty)
               }
            
            ForEach(0..<cards.count, id: \.self) { index in
                CardView(card: cards[index], onSwipedLeft: {
                    let removedCard = cards.remove(at: index)
                    cardsToPractice.append(removedCard)
                }, onSwipedRight: {
                    let removedCard = cards.remove(at: index)
                    cardsMemorized.append(removedCard)
                })
                .rotationEffect(.degrees(Double(cards.count - 1 - index) * -5))
            }
        }
        .id(deckId)
        .animation(.bouncy, value: cards)
    }
}

#Preview {
    ContentView()
}
