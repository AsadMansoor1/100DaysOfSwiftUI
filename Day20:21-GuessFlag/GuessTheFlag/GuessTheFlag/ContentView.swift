//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dev on 31/01/2023.
//

import SwiftUI


struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}
struct FlagImage: View {
    var flagName: String
    var body: some View {
        Image("\(flagName)")
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
struct ContentView: View {
    
    @State private var userSelectedFlagNumber = 0
    @State private var userScore = 0
    @State private var scoreTitle = ""
    @State private var showScore = false
    @State private var showGameComplete = false
    @State private var roundNumber = 1
    
   @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    var body: some View {
        ZStack {
            
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 150, endRadius: 700)
                .ignoresSafeArea()
                
            VStack{
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the Flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagMatch(number)
                        } label: {
                            FlagImage(flagName: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                HStack {
                    Text("Round \(roundNumber)")
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showScore){
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Correct" {
                Text("Your score is \(userScore)")
            }
            else {
                Text("Wrong! That’s the flag of \(countries[userSelectedFlagNumber])")
            }
        }
        .alert("Game Over", isPresented: $showGameComplete) {
            Button("Start New Game", action: startNewGame)
        } message: {
            Text("Your score is \(userScore)")
        }
    }
    private func flagMatch(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            self.userScore += 10
        }
        else {
            scoreTitle = "Wrong"
            self.userScore -= 10
        }
        userSelectedFlagNumber = number
        if roundNumber == 8 {
            showScore = false
            showGameComplete = true
        }
        else {
            showScore = true
        }
    }
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        showScore = false
        
        if roundNumber < 8 {
            roundNumber += 1
            showGameComplete = false
        }
        else {
            showGameComplete = true
        }
    }
    private func startNewGame() {
        roundNumber = 1
        showGameComplete = false
        userScore = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
