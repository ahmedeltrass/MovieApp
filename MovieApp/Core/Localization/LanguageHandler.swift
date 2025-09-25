//
//  Language.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import Foundation
import UIKit

// constants
let appleLanguageKey = "AppleLanguages"
private let firstTimeLanguage = "firstTimeLanguage"

/// L102Language
class LanguageHandler {

    class func currentLanguage() -> Language {
        setDefaultLanguage()
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: appleLanguageKey) as! NSArray
        let current = langArray.firstObject as! String
        
        // Extract the language part before hyphen if any
        if let hyphenIndex = current.firstIndex(of: "-") {
            return Language(rawValue: String(current[..<hyphenIndex])) ?? .arabic
        }
        
        return Language(rawValue: current) ?? .arabic
    }

    /// Set @lang to be the first in AppleLanguages list
    class func setLanguage(_ language: Language) {
        let userdef = UserDefaults.standard
        userdef.set([language.hyphenatedCode], forKey: appleLanguageKey)
        userdef.synchronize()
    }

    /// Set default language based on the device's current language
    public class func setDefaultLanguage(_ language: Language = .arabic) {
        let userdef = UserDefaults.standard

        // Only set the language the first time the app is launched
        if !userdef.bool(forKey: firstTimeLanguage) {
            // Always set the app language to Arabic on first launch
            LanguageHandler.setLanguage(.arabic)
            
            // Mark that the language has been set for the first time
            userdef.set(true, forKey: firstTimeLanguage)
        }
    }

    class var isArabic: Bool {
        return LanguageHandler.currentLanguage().code == "ar"

    }
}
