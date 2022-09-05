//
//  SoundManager.swift
//  ShutTheBox
//
//  Created by İbrahim Erdogan on 5.09.2022.
//

import Foundation
import AVKit


class SoundManager
{
    static let instance = SoundManager()
    var player : AVAudioPlayer?
    enum sound : String{
        case tada
        case click
        case boing
        case hit
    }
    
    func playMusic(sound : sound)
    {
        guard let url = Bundle.main.url(forResource: sound.rawValue , withExtension: "mp3") else {return}
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }catch{
            print(error.localizedDescription)
        }
            
        
            
    }
}
