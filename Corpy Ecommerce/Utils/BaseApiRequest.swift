//
//  BaseApiRequest.swift
//  Corpy Ecommerce
//
//  Created by Peter Bassem on 11/4/18.
//  Copyright © 2018 corpy. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class BaseApiRequest {
    class func login(URL: String, email: String, password: String, onCompletion completion: @escaping (_ error: Error?, _ data: BaseResponse?) -> Void) {
        let param: [String: Any] = [
            "email": "\(email)",
            "password": "\(password)"
        ]
        Alamofire.request(URL, method: HTTPMethod.post, parameters: param, encoding: JSONEncoding(options: []), headers: nil).responseData { (data) in
            if let error = data.error {
                completion(error, nil)
            }
            guard let data = data.data else { return }
            do {
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(BaseResponse.self, from: data)
                completion(nil, response)
            } catch (let error) {
                completion(error, nil)
            }
        }
    }
    
    class func socialLogin(URL: String, username: String, email: String, onCompletion completion: @escaping (_ error: Error?, _ data: BaseResponse?) -> Void) {
        let param: [String: Any] = [
            "username": "\(username)",
            "email": "\(email)",
            "provider": "facebook"
        ]
        print(param)
        Alamofire.request(URL, method: HTTPMethod.post, parameters: param, encoding: JSONEncoding(options: []), headers: nil).responseData { (data) in
            if let error = data.error {
                completion(error, nil)
            }
            guard let  data = data.data else { return }
            do {
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(BaseResponse.self, from: data)
                completion(nil, response)
            } catch (let error) {
                completion(error, nil)
            }
        }
    }
    
    class func signUpUser(URL: String, name: String, email: String, password: String, onCompletion completion: @escaping (_ error: Error?, _ data: BaseResponse?) -> Void) {
        let param: [String: Any] = [
            "name": "\(name)",
            "email": "\(email)",
            "password": "\(password)",
            "level": "user"
        ]
        Alamofire.request(URL, method: HTTPMethod.post, parameters: param, encoding: JSONEncoding(options: []), headers: nil).responseData { (data) in
            if let error = data.error {
                completion(error, nil)
            }
            guard let  data = data.data else { return }
            do {
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(BaseResponse.self, from: data)
                completion(nil, response)
            } catch (let error) {
                completion(error, nil)
            }
        }
    }
}
