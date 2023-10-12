//
//  WeatherInfoApi.swift
//  Weather
//
//  Created by 邹贤琳 on 2023/10/11.
//

import Foundation
import PromiseKit
import Moya
import Security

struct WeatherInfoApi {
    static func getWeatherInfo(city: String,
                               extensions: String = "all") -> Promise<WeatherResponse> {
        let target = BaseRequest.init(path: "/v3/weather/weatherInfo",
                                      method: .get,
                                      task: .requestParameters(parameters: ["extensions": extensions,
                                                                            "city": city,
                                                                            "key": KeychainService.getAmapKey()], encoding: URLEncoding()))
        return NetworkManager.request(target: target)
    }
}
