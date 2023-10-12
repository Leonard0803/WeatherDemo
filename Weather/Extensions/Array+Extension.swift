//
//  Array+Extension.swift
//  Weather
//
//  Created by 邹贤琳 on 2023/10/12.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
