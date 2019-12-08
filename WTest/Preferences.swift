//
//  Preferences.swift
//  WTest
//
//  Created by Alan Filipe Cardozo Fabeni on 08/12/19.
//  Copyright © 2019 Alan Filipe Cardozo Fabeni. All rights reserved.
//

import Foundation

enum UserDefaultKeys: String {    
    case synchronizationIsFinished = "synchronizationIsFinished"
}

class Preferences {
    
    let defaults = UserDefaults.standard
    static var shared: Preferences = Preferences()
    
    var synchronizationIsFinished: Bool? {
        get {
            return defaults.bool(forKey: UserDefaultKeys.synchronizationIsFinished.rawValue)
        }
        
        set {
            defaults.set(newValue, forKey: UserDefaultKeys.synchronizationIsFinished.rawValue)
        }
    }
    
}

