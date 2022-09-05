//
//  Extensions.swift
//  ShutTheBox
//
//  Created by İbrahim Erdogan on 2.09.2022.
//

import Foundation
import SwiftUI


extension View {
    func DiceBackgroundModifier() -> some View
    {
        modifier(DiceModifier())
    }
    
    func StoneNumberBackgroundModifier(color : Color) -> some View
    {
        modifier(StoneNumberModifier(borderColor: color))
    }
    
    func PlayerViewDesignModifier(switchPlayer : Bool) -> some View
    {
        modifier(PlayerModifier(switchPlayer: switchPlayer))
    }
    
    func ButtonViewModifier(backgroundColor : Color) -> some View
    {
        modifier(ButtonModifier(backgroundColor: backgroundColor))
    }
    
    func ContinueContainerModifier() -> some View
    {
        modifier(ContinueModifier())
    }
    
    func ContinueButtonBackgroundModifier() -> some View
    {
        modifier(ContinueButtonModifier())
    }
}


struct DiceModifier : ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth:60,maxHeight: 60)
            .foregroundColor(.white)
            .border(.black)
            .shadow(color: .black, radius: 10, x: 2, y: 1)
    }
}

struct StoneNumberModifier : ViewModifier{
    
    var borderColor : Color
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth:80 ,maxHeight :100)
            .background(Color.brown)
            .border(borderColor, width: 2)
    }
}

struct PlayerModifier : ViewModifier{
    var switchPlayer : Bool
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.title2)
            .background(switchPlayer ? Color.green : Color.gray)
            .cornerRadius(20)
            .padding()
    }
}

struct ButtonModifier : ViewModifier
{
    var backgroundColor : Color
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .foregroundColor(.black)
            .frame(width: 100, height: 30)
            .padding()
            .background(backgroundColor)
            .cornerRadius(20)
          
    }
}

struct ContinueModifier : ViewModifier
{
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth:320,maxHeight:200)
            .background(Color.white)
            .cornerRadius(20)
            .transition(.scale.animation(.spring()))
    }
}

struct ContinueButtonModifier : ViewModifier
{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth:200)
            .background(Color.green)
            .cornerRadius(20)
    }
}
