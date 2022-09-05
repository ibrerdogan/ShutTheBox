//
//  GameView.swift
//  ShutTheBox
//
//  Created by İbrahim Erdogan on 3.09.2022.
//

import SwiftUI

struct GameView: View {
   
    //stones
    @State var stoneDegree = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    @State var stoneIsClicked = [true,true,true,true,true,true,true,true,true]
    @State var resetGame : Bool = false
    
    //player
    @State var switchPlayer = true
    @State var playerScore = 0
    @State var player2Score = 0
    
    //dice
    @State var degree_1 = 0.0
    @State var degree_2 = 0.0
    @State var rotation_1 = 0.0
    @State var rotation_2 = 0.0
    @State var number_1 = 6
    @State var number_2 = 6
    @State var roll = false
    
    //game
    @State var lastValue = 0
    @State var totalValue = 0
    @State var endGame : Bool = false
    @State var winner : String = ""
    @State var winnerScore : Int = 0
    var body: some View {
        ZStack{
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea()
            VStack
            {
                HStack{
                    
                     StoneView(value: $totalValue, stoneValue: 1, degree: $stoneDegree[0], isClicked: $stoneIsClicked[0], reset: $resetGame)
                     StoneView(value: $totalValue, stoneValue: 2, degree: $stoneDegree[1], isClicked: $stoneIsClicked[1], reset: $resetGame)
                     StoneView(value: $totalValue, stoneValue: 3, degree: $stoneDegree[2], isClicked: $stoneIsClicked[2], reset: $resetGame)
                     StoneView(value: $totalValue, stoneValue: 4, degree: $stoneDegree[3], isClicked: $stoneIsClicked[3], reset: $resetGame)
                     StoneView(value: $totalValue, stoneValue: 5, degree: $stoneDegree[4], isClicked: $stoneIsClicked[4], reset: $resetGame)
                     StoneView(value: $totalValue, stoneValue: 6, degree: $stoneDegree[5], isClicked: $stoneIsClicked[5], reset: $resetGame)
                     StoneView(value: $totalValue, stoneValue: 7, degree: $stoneDegree[6], isClicked: $stoneIsClicked[6], reset: $resetGame)
                     StoneView(value: $totalValue, stoneValue: 8, degree: $stoneDegree[7], isClicked: $stoneIsClicked[7], reset: $resetGame)
                     StoneView(value: $totalValue, stoneValue: 9, degree: $stoneDegree[8], isClicked: $stoneIsClicked[8], reset: $resetGame)
                     
                    
                 }
                 .padding()
                Spacer()
                HStack{
                    PlayerView(switchPlayer: switchPlayer , playerScore: playerScore, name: "Player 1")
                    Spacer()
                    VStack
                    {
                        HStack
                        {
                            DiceView(degree: $degree_1, isClicked: $roll, rotation: $rotation_1, number: $number_1)
                               
                            DiceView(degree: $degree_2, isClicked: $roll, rotation: $rotation_2, number: $number_2)
                        }
                        .padding()
                        
                        if totalValue == 0
                        {
                            Button {
                                lastValue = 0
                                RollDices()
                                IncreaseLastValue()
                            } label: {
                                Text("Roll")
                                    .ButtonViewModifier(backgroundColor: .green)
                            }
                        }
                       else
                        {
                           Button {
                               withAnimation(.linear) {
                                  if switchPlayer
                                   {
                                      playerScore = playerScore + lastValue
                                  }
                                   else
                                   {
                                       player2Score = player2Score + lastValue
                                   }
                                   resetGame.toggle()
                                   for i in 0...8
                                   {
                                       if !stoneIsClicked[i] {
                                           stoneDegree[i] = 0.0
                                           stoneIsClicked[i].toggle()
                                       }
                                   }
                                   if playerScore > 100 || player2Score > 100
                                   {
                                       if playerScore > 100
                                       {
                                           winner = "Player 2"
                                           winnerScore = player2Score
                                       }
                                       else
                                       {
                                           winner = "Player 1"
                                           winnerScore = playerScore
                                       }
                                       endGame.toggle()
                                   }
                                   lastValue = 45
                                   totalValue = 0
                                   switchPlayer.toggle()
                               }
                           } label: {
                               Text("Pass")
                                   .ButtonViewModifier(backgroundColor: .red)
                           }
                       }
                    }
                    Spacer()
                    PlayerView(switchPlayer: !switchPlayer, playerScore: player2Score, name: "Player 2")
                }
            }
            
            
           if endGame
            {
               VStack{
                   EndGameView(player: winner, score: winnerScore)
                   Button {
                       EndGame()
                   } label: {
                       Text("Continue")
                           .bold()
                           .ContinueButtonBackgroundModifier()
                   }

               }.ContinueContainerModifier()
           }
        }
      
    }
    
    func RollDices()
    {
        withAnimation(.spring(response: 0.2, dampingFraction: 3.0, blendDuration: 1.0)) {
            rotation_1 = Double.random(in: 0...360)
            rotation_2 = Double.random(in: 0...360)
            
            if roll
            {
                degree_1 = 360
                degree_2 = 360
            }
            else
            {
                degree_1 = 0
                degree_2 = 0
            }
            roll.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    number_1 = Int.random(in: 1...6)
                    number_2 = Int.random(in: 1...6)
                    totalValue = number_1 + number_2
                }
            }
            
        }
    }
    func IncreaseLastValue()
    {
        for i in 0...8
        {
            if stoneIsClicked[i]
            {
                lastValue = lastValue + i+1
            }
        }
    }
    func EndGame()
    {
        resetGame.toggle()
        for i in 0...8
        {
            if !stoneIsClicked[i] {
                stoneDegree[i] = 0.0
                stoneIsClicked[i].toggle()
            }
        }
        playerScore = 0
        player2Score = 0
        winner = ""
        winnerScore = 0
        endGame.toggle()
    }
}



struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
