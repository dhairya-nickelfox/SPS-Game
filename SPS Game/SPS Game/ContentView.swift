//
//  ContentView.swift
//  SPS Game
//
//  Created by Dhairya bhardwaj on 25/12/24.
//

import SwiftUI

//enum choices:String,CaseIterable{
//    case stone = "💎"
//    case paper = "📄"
//    case scissor = "✂️"
//}

//let randomChoice = Int.random(in: 0..<choices.count)
//let currentQuestion = choices[randomChoice]


struct ContentView: View {
    let choices = ["💎", "📄", "✂️"]
    @State private var resultMessage: String = ""
    @State private var computerChoice = "❔"
    @State private var score: Int = 0
    @State private var showScoreAlert: Bool = false
    @State private var currentQuestion = 1
    let maxQuestions = 10
    
    
    
    var body: some View {
        ZStack{
            Color.red.opacity(0.2)
                .ignoresSafeArea()
            VStack(spacing:20){
                Text("Stone Paper Scisor")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.blue)
                Text("round of \(currentQuestion): \(maxQuestions)")
                    .bold()
                    .font(.title3)
                Text(computerChoice)
                    .font(.system(size:100))
                    .font(.title)
                Text("Your Score : \(score)")
                    .font(.title2)
                    .bold()
                HStack(spacing :30){
                    ForEach(choices,id: \.self){choice in
                        Button(action:{
                            playerGame(playerChoice: choice)
                        }){
                            Text(choice)
                                .font(.system(size: 50))
                                .padding()
                            
                            
                        }
                    }
                    
                }
                Text("Result: \(resultMessage)")
                    .font(.title2)
                
                
            }
            .padding()
            .alert(isPresented: $showScoreAlert){
                Alert(
                    title: Text("Game Over"),
                    message: Text("Your Score : \(score)"),
                    dismissButton: .default(Text("OK"),action: resetGame)
                )
            }
        }
    }
    func playerGame(playerChoice:String){
        computerChoice = choices.randomElement()!
        print("Player choice: \(playerChoice), Computer choice: \(computerChoice)")
                
                if isWinning(player: playerChoice, computer: computerChoice) {
                    score += 1
                    resultMessage = "You win"
                } else if playerChoice == computerChoice {
                    resultMessage = "Its a tie"
                } else {
                    score -= 1
                    resultMessage = "You lose"
                }
                
                currentQuestion += 1
                if currentQuestion > maxQuestions {
                    showScoreAlert = true
                } 
            }
        
        
        
    func isWinning(player: String, computer: String) -> Bool {
        switch (player, computer) {
        case ("💎", "✂️"), ("✂️", "📄"), ("📄", "💎"):
            return true
        default:
            return false
        }
    }

        func resetGame(){
            score = 0
            currentQuestion = 1
            computerChoice = "❔"
            resultMessage = ""
            
        }
    }



#Preview {
    ContentView()
}
