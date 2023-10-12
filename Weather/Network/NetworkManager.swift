//
//  NetworkManager.swift
//  Weather
//
//  Created by 邹贤琳 on 2023/10/11.
//

import Foundation
import Moya
import HandyJSON
import PromiseKit

struct NetworkManager {
    
    enum NetworkError: Error {
        case deserializationFail
        case businessError(String, String)
        case somethingWrong
    }
    
    enum Result: String, HandyJSONEnum {
        case success = "1"
        case failure = "0"
    }
    
    static func request<T: BaseResponse, U: TargetType>(target: U) -> Promise<T> {
        return Promise { resolver in
            MoyaProvider<U>().request(target) { result in
                switch result {
                case .success(let resopnse):
                    do {
                        let response = try resopnse.mapJSON() as! [String: Any]
                        guard let model = T.deserialize(from: response) else {
                            throw NetworkError.deserializationFail
                        }
                        if model.status == .success {
                            resolver.fulfill(model)
                        } else {
                            resolver.reject(NetworkError.businessError(model.infocode, model.info))
                        }
                    } catch {
                        resolver.reject(NetworkError.deserializationFail)
                    }
                case .failure(_):
                    resolver.reject(NetworkError.somethingWrong)
                }
            }
        }
    }
}
