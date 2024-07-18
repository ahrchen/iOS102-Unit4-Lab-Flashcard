//
//  CardView.swift
//  Flashcard
//
//  Created by Raymond Chen on 7/18/24.


import SwiftUI

struct CardView: View {
    
    @State private var isShowingQuestion = true
    
    let card: Card
    
    var body: some View {
        ZStack {
            // Card background
               RoundedRectangle(cornerRadius: 25.0)
                .fill(isShowingQuestion ? Color.blue.gradient : Color.indigo.gradient)
                .shadow(color: .black, radius: 4, x: -2, y: 2)
            
            // Card text
            VStack(spacing: 20) {
                Text(isShowingQuestion ? "Question" : "Answer")
                    .bold()
                
                Rectangle()
                    .frame(height: 1)
                
                Text(isShowingQuestion ? card.question : card.answer)
                    
            }
            .font(.title)
            .foregroundStyle(.white)
            .padding()
        }
        .frame(width: 300, height: 500)
        .onTapGesture {
            isShowingQuestion.toggle()
        }
        
    }
}

#Preview {
    CardView(card: Card(
        question: "Located at the southern end of Puget Sound, what is the capitol of Washington?",
        answer: "Olympia"))
}
