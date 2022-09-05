//
//  StoneView.swift
//  ShutTheBox
//
//  Created by İbrahim Erdogan on 2.09.2022.
//

import SwiftUI
import AVKit

struct StoneView: View {
    
    
    @Binding var value : Int
    var stoneValue : Int
    @Binding var degree : Double
    @Binding var isClicked : Bool
    @State var borderColor = Color.black
    @Binding var reset : Bool
    var manager = SoundManager()
    
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
        .StoneNumberBackgroundModifier(color: borderColor)
        .rotation3DEffect(Angle.degrees(degree), axis: (x: 1  , y: 0, z: 0))
        .onTapGesture {
            manager.playMusic(sound: .click)
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

