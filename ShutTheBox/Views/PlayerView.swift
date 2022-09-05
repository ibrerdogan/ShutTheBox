//
//  PlayerView.swift
//  ShutTheBox
//
//  Created by İbrahim Erdogan on 3.09.2022.
//

import SwiftUI

struct PlayerView: View {
    var switchPlayer : Bool
    var playerScore : Int
    var name : String
    var body: some View {
        VStack{
            Text(name)
                .PlayerViewDesignModifier(switchPlayer: switchPlayer)
            Text("Score : \(playerScore)")
                .foregroundColor(.white)
                .font(.title2)
                .bold()
            Spacer()
        }
        .padding()
    }
}

