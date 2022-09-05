//
//  DiceView.swift
//  ShutTheBox
//
//  Created by İbrahim Erdogan on 2.09.2022.
//

import SwiftUI

struct DiceView: View
{
    @Binding var degree : Double
    @Binding var isClicked : Bool
    @Binding var rotation : Double
    @Binding var number : Int
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .DiceBackgroundModifier()
           Image("dice\(number)")
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
                
           
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 2, y: 10, z: 0))
        .rotationEffect(Angle(degrees: rotation))
        .onTapGesture {
            withAnimation(.spring(response: 0.2, dampingFraction: 3.0, blendDuration: 1.0)) {
              Rolling()
            }
        }
    }
    
    func Rolling()
    {
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


