//
//  BaseRequest.swift
//  Weather
//
//  Created by 邹贤琳 on 2023/10/11.
//

import Foundation
import Moya
import HandyJSON

struct BaseRequest: TargetType {
    
    var path: String
    
    var method: Moya.Method
    
    var task: Moya.Task
    
    var baseURL: URL {
        return URL.init(string: "https://restapi.amap.com")!
    }
    
    var headers: [String : String]?
}

class BaseResponse: HandyJSON {
    
    var status: NetworkManager.Result = .success
    var info: String = ""
    var infocode: String = ""
    
    required init() {}
}
