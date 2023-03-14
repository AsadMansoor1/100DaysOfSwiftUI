//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Dev on 3/6/23.
//

import SwiftUI

struct CircularBackgroundForOnboarding: ViewModifier {
    var padding: CGFloat
    var background: Color
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(background)
            .clipShape(Circle())
            .shadow(radius: 10)
    }
}
extension View {
    func circularBackgroundForOnboarding(padding: CGFloat, color: Color) -> some View {
        modifier(CircularBackgroundForOnboarding(padding: padding, background: color))
    }
}

struct OnboardView: View {
    
    @State private var isShowingGameView = false
    
    var body: some View {
        
        NavigationStack {
            ZStack{
                Color.indigo
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    
                    VStack {
                        Text("✋")
                            .font(.system(size: 80))
                        HStack {
                            Text("✊")
                                .font(.system(size: 80))
                            Text("✌️")
                                .font(.system(size: 80))
                        }
                        .padding(.bottom, 20)
                    }
                    .circularBackgroundForOnboarding(padding: 40, color: .white)
                    .circularBackgroundForOnboarding(padding: 20, color: .red)
                    
                    Spacer()
                    
                    VStack {
                        Text("Rock")
                            .font(.largeTitle.weight(.heavy))
                            .foregroundColor(.white)
                        Text("Paper")
                            .font(.largeTitle.weight(.heavy))
                            .foregroundColor(.white)
                        Text("Scissors")
                            .font(.largeTitle.weight(.heavy))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    Spacer()
                    
                    VStack {
                        Button {
                            isShowingGameView = true
                        } label: {
                            Text("Start Playing")
                                .font(.system(size: 40).weight(.bold))
                                .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
                                .foregroundColor(.white)
                        }
                        .background(.pink)
                        .clipShape(Capsule())
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("")
            .navigationDestination(isPresented: $isShowingGameView) {
                GameView()
            }
        }
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView()
    }
}
