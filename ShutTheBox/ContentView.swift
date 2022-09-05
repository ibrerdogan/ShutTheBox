//
//  ContentView.swift
//  ShutTheBox
//
//  Created by İbrahim Erdogan on 1.09.2022.
//

import SwiftUI

struct ContentView: View {
    @State var totalValue = 0
    @State var roll = false
    @State var degree_1 = 0.0
    @State var rotation_1 = 0.0
    @State var number_1 = 6
    @State var degree_2 = 0.0
    @State var rotation_2 = 0.0
    @State var number_2 = 6
    @State var resetGame : Bool = false
    @State var stoneDegree = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    @State var stoneIsClicked = [true,true,true,true,true,true,true,true,true]
    @State var lastValue = 0
    @State var playerScore = 0
    @State var player2Score = 0
    @State var switchPlayer = true
    
    var body: some View {
        
        ZStack
        {
            
            VStack{
                HStack{
                    
                     StoneView2(value: $totalValue, stoneValue: 1, degree: $stoneDegree[0], isClicked: $stoneIsClicked[0], reset: $resetGame)
                     StoneView2(value: $totalValue, stoneValue: 2, degree: $stoneDegree[1], isClicked: $stoneIsClicked[1], reset: $resetGame)
                     StoneView2(value: $totalValue, stoneValue: 3, degree: $stoneDegree[2], isClicked: $stoneIsClicked[2], reset: $resetGame)
                     StoneView2(value: $totalValue, stoneValue: 4, degree: $stoneDegree[3], isClicked: $stoneIsClicked[3], reset: $resetGame)
                     StoneView2(value: $totalValue, stoneValue: 5, degree: $stoneDegree[4], isClicked: $stoneIsClicked[4], reset: $resetGame)
                     StoneView2(value: $totalValue, stoneValue: 6, degree: $stoneDegree[5], isClicked: $stoneIsClicked[5], reset: $resetGame)
                     StoneView2(value: $totalValue, stoneValue: 7, degree: $stoneDegree[6], isClicked: $stoneIsClicked[6], reset: $resetGame)
                     StoneView2(value: $totalValue, stoneValue: 8, degree: $stoneDegree[7], isClicked: $stoneIsClicked[7], reset: $resetGame)
                     StoneView2(value: $totalValue, stoneValue: 9, degree: $stoneDegree[8], isClicked: $stoneIsClicked[8], reset: $resetGame)
                     
                    
                 }
                 .padding()
                Spacer()
               HStack
                {
                    VStack{
                        Text("Player 1")
                            .padding()
                            .font(.title2)
                            .background(switchPlayer ? Color.green : Color.gray)
                            .cornerRadius(20)
                    
                            .padding()
                        Text("Score : \(playerScore)")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    .padding()
                    Spacer()
                    VStack{
                        HStack(spacing: 20){
                            DiceView2(degree: $degree_1, isClicked: $roll, rotation: $rotation_1, number: $number_1)
                            DiceView2(degree: $degree_2, isClicked: $roll, rotation: $rotation_2, number: $number_2)
                           
                        }
                        .padding()
                        
                        
                        //Text("\(lastValue)")
                        Text("\(totalValue)")
                            .padding()
                        //Text("\(number_1 + number_2)")
                        if totalValue == 0
                        {
                            Button {
                                lastValue = 0
                                RollDices()
                                for i in 0...8
                                {
                                    if stoneIsClicked[i]
                                    {
                                        lastValue = lastValue + i+1
                                    }
                                }
                                if lastValue < number_1 + number_2
                                {
                                    withAnimation(.linear) {
                                        resetGame.toggle()
                                        for i in 0...8
                                        {
                                            if !stoneIsClicked[i] {
                                                stoneDegree[i] = 0.0
                                                stoneIsClicked[i].toggle()
                                            }
                                        }
                                    }
                                }
                            } label: {
                                Text("Roll")
                                    .font(.title)
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
                                   if playerScore > 45 || player2Score > 45
                                   {
                                       
                                   }
                                   lastValue = 45
                                   totalValue = 0
                                   switchPlayer.toggle()
                               }
                           } label: {
                               Text("Quit")
                                   .font(.title)
                           }
                       }

                    
                    }
                    Spacer()
                    VStack{
                        Text("Player 2")
                            .padding()
                            .font(.title2)
                            .background(switchPlayer ? Color.gray : Color.green)
                            .cornerRadius(20)
                            .padding()
                        Text("Score : \(player2Score)")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    .padding()
                }
              
               
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
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.landscapeLeft)
            
    }
}


struct StoneView2 : View
{
    @Binding var value : Int
    var stoneValue : Int
    @Binding var degree : Double
    @Binding var isClicked : Bool
    var durationDelay = 10.0
    @State var borderColor = Color.black
    @Binding var reset : Bool
    var body: some View{
        VStack{
            if isClicked
            {
                Text("\(stoneValue)")
                    .font(.largeTitle)
                    .bold()
                   
            }
            else
            {
                Image("wood")
                    .resizable()
                    .frame(maxWidth:80 ,maxHeight :100)
            }
           
        }
        .frame(maxWidth:80 ,maxHeight :100)
        .background(Color.brown)
        .border(borderColor, width: 2)
        .rotation3DEffect(Angle.degrees(degree), axis: (x: 1  , y: 0, z: 0))
        .onTapGesture {
            if isClicked{
                let lastvalue = value - stoneValue
                if lastvalue >= 0
                {
                    withAnimation(.spring(response: 1, dampingFraction: 1, blendDuration: 2)) {
                        if degree == 180.0{
                            degree = 0.0
                        }
                        else
                        {
                            degree = 180.0
                        }
                        isClicked = false
                        value = value - stoneValue
                    }
                }
                else
                {
                    borderColor = Color.red
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    borderColor = Color.black
                }
            }
            
        }
        
    }
}

struct DiceView2 : View
{
    @Binding var degree : Double
    @Binding var isClicked : Bool
    @Binding var rotation : Double
    @Binding var number : Int
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth:60,maxHeight: 60)
                .foregroundColor(.white)
                .border(.black)
           Image("dice\(number)")
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
                .cornerRadius(20)
           
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 2, y: 10, z: 0))
        .rotationEffect(Angle(degrees: rotation))
        .onTapGesture {
            withAnimation(.spring(response: 0.2, dampingFraction: 3.0, blendDuration: 1.0)) {
                rotation = Double.random(in: 0...360)
                number = Int.random(in: 1...7)
                if isClicked
                {
                    degree = 360
                }
                else
                {
                    degree = 0
                }
                isClicked.toggle()
            }
        }
    }
}
