//
//  WeatherModel.swift
//  Weather
//
//  Created by 邹贤琳 on 2023/10/11.
//

import Foundation
import HandyJSON

class WeatherResponse: BaseResponse {
    var forecasts: [Forecast] = []
}

struct DailyForecast: HandyJSON {
    var date: String = ""
    var week: Weekday = .monday
    var dayweather: String = ""
    var nightweather: String = ""
    var daytemp: String = ""
    var nighttemp: String = ""
    var daywind: String = ""
    var nightwind: String = ""
    var daypower: String = ""
    var nightpower: String = ""
    var daytemp_float: String = ""
    var nighttemp_float: String = ""
}

struct Forecast: HandyJSON {
    var city: String = ""
    var adcode: String = ""
    var province: String = ""
    var reporttime: String = ""
    var casts: [DailyForecast] = []
}

enum Weekday: Int, HandyJSONEnum {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case sunday = 7
    
    var name: String {
        switch self {
        case .monday:
            return "星期一"
        case .tuesday:
            return "星期二"
        case .wednesday:
            return "星期三"
        case .thursday:
            return "星期四"
        case .friday:
            return "星期五"
        case .saturday:
            return "星期六"
        case .sunday:
            return "星期日"
        }
    }
}
