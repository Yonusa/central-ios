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
    
    func on(name className: String) {
        Crashlytics.crashlytics().setCustomValue(className, forKey: "Controller")
    }
}
