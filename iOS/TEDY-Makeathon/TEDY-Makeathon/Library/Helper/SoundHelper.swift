//
//  SoundHelper.swift
//  TEDY-Makeathon
//
//  Created by KL on 13/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation
import AVFoundation

class SoundHelper {
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    static let shared = SoundHelper()
    
    private init() {
        
    }
    
    func speak(_ text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        let voice = AVSpeechSynthesisVoice.speechVoices().first { (voice) -> Bool in
            return voice.language == "zh-HK" && voice.quality == AVSpeechSynthesisVoiceQuality.enhanced
            }
        if let voice = voice {
            print("\(voice.name) selected as voice for uttering speeches. Quality: \(voice.quality.rawValue)")
            speechUtterance.voice  = voice
        }else {
            speechUtterance.voice  = AVSpeechSynthesisVoice(language: "zh-HK")
        }
        
        speechSynthesizer.speak(speechUtterance)
    }
}
