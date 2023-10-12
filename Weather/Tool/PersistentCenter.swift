//
//  PersistentCenter.swift
//  Weather
//
//  Created by 邹贤琳 on 2023/10/12.
//

import Foundation

@propertyWrapper
struct PersistentCenter<T: Codable> {

    let key: String
    let defaultValue: [T]
    var wrappedValue: [T] {
        get {
            if let data = UserDefaults.standard.data(forKey: key),
               let value = try? JSONDecoder().decode([T].self, from: data) {
                return value
            }
            return defaultValue
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: key)
            }
        }
    }
}

extension String {
    static let weatherDisplayPreferences = "weatherDisplayPreferences"
}
