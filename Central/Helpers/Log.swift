//
//  Log.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 14/01/23.
//

import Foundation
import FirebaseCrashlytics

class Log {
    static let shared: Log = Log()
    
    private var crashlytics = Crashlytics.crashlytics()
    
    func on(file: String) {
        crashlytics.setCustomValue(file, forKey: "Current file")
    }
}
