//
//  EndGameView.swift
//  ShutTheBox
//
//  Created by İbrahim Erdogan on 5.09.2022.
//

import SwiftUI

struct EndGameView: View {
    var player : String = ""
    var score : Int = 0
    var body: some View {
        VStack{
            Text("Winner").bold()
                .font(.largeTitle)
                .padding()
            Text(player).bold()
            Text("Score : \(score)")
        }
    }
}

