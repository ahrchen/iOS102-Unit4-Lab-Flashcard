//
//  CardView.swift
//  Flashcard
//
//  Created by Raymond Chen on 7/18/24.


import SwiftUI

struct CardView: View {
    
    private let swipeThreshold: Double = 200 // <--- Define a swipeThreshold constant top level
    @State private var isShowingQuestion = true
    @State private var offset: CGSize = .zero // <-- A state property to store the offset

    let card: Card
    
    var onSwipedLeft: (() -> Void)?
    var onSwipedRight: (() -> Void)?
    
    var body: some View {
        ZStack {
            ZStack {
                // Back-most card background
                    RoundedRectangle(cornerRadius: 25.0) // <-- Add another card background behind the original
                        .fill(offset.width < 0 ? .red : .green) // <-- Set fill based on offset (swipe left vs right)
                
                // Front-most card background (i.e. original background)
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(isShowingQuestion ? Color.blue.gradient : Color.indigo.gradient)
                    .shadow(color: .black, radius: 4, x: -2, y: 2)
                    .opacity(1 - abs(offset.width) / swipeThreshold)
            }
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
        .opacity(3 - abs(offset.width) / swipeThreshold * 3)
        .rotationEffect(.degrees(offset.width / 20.0))
        .offset(CGSize(width:offset.width, height: 0))
        .gesture(DragGesture()
            .onChanged { gesture in // <-- onChanged called for every gesture value change, like when the drag translation changes
                let translation = gesture.translation // <-- Get the current translation value of the gesture. (CGSize with width and height)
                print(translation) // <-- Print the translation value
                offset = translation
            }.onEnded { gesture in  // <-- onEnded called when gesture ends
                
                if gesture.translation.width > swipeThreshold { // <-- Compare the gesture ended translation value to the swipeThreshold
                    print("👉 Swiped right")
                    onSwipedRight?()
                } else if gesture.translation.width < -swipeThreshold {
                    print("👈 Swiped left")
                    onSwipedLeft?()
                } else {
                    print("🚫 Swipe canceled")
                    withAnimation(.bouncy) {
                        offset = .zero
                    }
                }
            }
        )
        
    }
}

#Preview {
    CardView(card: Card(
        question: "Located at the southern end of Puget Sound, what is the capitol of Washington?",
        answer: "Olympia"))
}
