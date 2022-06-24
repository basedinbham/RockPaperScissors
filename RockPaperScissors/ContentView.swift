//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Kyle Warren on 6/21/22.
//

import SwiftUI

struct ContentView: View {
    let moves = ["✊", "✋", "✌️"]
    
    @State private var currentChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var questionCount = 1
    @State private var showingResults = false
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.5, blue: 0.5), location: 0.1),
                .init(color: Color(red: 0.7, green: 0.6, blue: 0.2), location: 0.3)
            ],center: .top, startRadius: 400, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Computer has played...")
                    .font(.largeTitle.bold())
                    .foregroundColor(.black)
                
                
                Text(moves[currentChoice])
                    .font(.system(size: 80))
                
                if shouldWin {
                    Text("Which one wins?")
                        .font(.title)
                } else {
                    Text("Which one loses?")
                        .foregroundColor(.red)
                        .font(.title)
                }
                
                HStack {
                    ForEach(0..<3) { number in
                        Button(moves[number]) {
                            play(choice: number)
                        }
                        .buttonStyle(.bordered)
                        .tint(.secondary)
                        .font(.system(size: 80))
                    }
                }
                
                Spacer()
                
                Text("Score: \(score)")
                    .font(.subheadline)
                
                Spacer()
            }
            .alert("Game Over", isPresented: $showingResults) {
                Button("Play Again", action: reset)
            } message: {
                Text("Your score was \(score)")
            }
        }
    }
    
    func play(choice: Int) {
        let winningMoves = [1, 2, 0]
        let didWin: Bool
        
        if shouldWin {
            didWin = choice == winningMoves[currentChoice]
        } else {
            didWin = winningMoves[choice] == currentChoice
        }
        
        if didWin {
            score += 1
        } else {
            score -= 1
        }
        
        if questionCount == 10 {
            showingResults = true
        } else {
            currentChoice = Int.random(in: 0..<3)
            shouldWin.toggle()
            questionCount += 1
        }
    }
    
    func reset() {
        currentChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        questionCount = 0
        score = 0
    }
}


    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
