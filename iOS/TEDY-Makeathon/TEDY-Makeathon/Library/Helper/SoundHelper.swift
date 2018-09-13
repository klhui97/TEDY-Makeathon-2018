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
        speechUtterance.voice  = AVSpeechSynthesisVoice(language: "zh-HK")
        speechSynthesizer.speak(speechUtterance)
    }
}
