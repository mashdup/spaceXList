//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Dillon Hoa on 17/07/2021.
//

import Foundation
import PromiseKit

class NetworkManager {
    
    enum Environment: String {
        case development = "https://api.spacexdata.com/v4"
    }
    
    enum Method: String {
        case get = "GET",
             post = "POST",
             put = "PUT",
             update = "UPDATE"
    }
    
    var environment: Environment = .development
    
    var baseUrlString: String {
        self.environment.rawValue
    }
    
    var session: URLSession {
        URLSession.shared
    }
    
    static var `default`: NetworkManager = {
        let n = NetworkManager()
        return n
    }()
    
    func headers() -> [String: String] {
        var headers: [String: String] = [: ]
        headers["Content-Type"] = "application/json"
        return headers
    }
    
    func request<T: Decodable>(_ objectType: T.Type, method: Method, path: String?, body: [String: Any]? = nil, completion: @escaping ((Swift.Result<T, Error>) -> Void)) {
        guard let baseUrl = URL(string: baseUrlString) else {
            completion(.failure(NSError(domain: "NO_BASE_URL", code: 0, userInfo: nil)))
            return
        }
        var url = baseUrl
        if let path = path {
            url = baseUrl.appendingPathComponent(path)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        headers().forEach({ key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        })
        
        if let body = body {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
                #if DEBUG
                print(String(data: jsonData, encoding: .utf8) ?? "")
                #endif
                urlRequest.httpBody = jsonData
            } catch {
                completion(.failure(error))
            }
        }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                  let response = response else {
                completion(.failure(NSError(domain: "NO_DATA_OR_RESPONSE", code: 0, userInfo: nil)))
                return
            }
            do {
                #if DEBUG
                print("RESPONSE:    \n\(response)\n\n")
                let jsonString = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                print(jsonString)
                #endif
                try self.checkResponse(response as? HTTPURLResponse)
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func checkResponse(_ response: HTTPURLResponse?) throws {
        guard let response = response else {
            throw NSError(domain: "NOT_VALID_HTTP_RESPONSE", code: 400, userInfo: nil)
        }
        switch response.statusCode {
        case 200...299:
            #if DEBUG
            print(response.description)
            #endif
        default:
            throw NSError(domain: response.description, code: response.statusCode, userInfo: nil)
        }
    }
}
