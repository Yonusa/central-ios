//
//  ProfileApi.swift
//  Yonusa Instaladores
//
//  Created by Yonusa iOS on 16/05/22.
//

import Foundation

enum ApiError: Error {
    case decoding(error: String)
    case server(error: String)
    case network(error: String)
    
    var localizedDescription: String {
        return "\(self)"
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum ContentType: String {
    case json = "application/json"
}

enum Headers: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data?
    var headers = [Headers.contentType: ContentType.json]
}

class Api {
    
    static func fetch<T>(resource: Resource<T>, completion: @escaping (Result<T, ApiError>) -> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        
        // HTTP Body
        if let body = resource.body {
            request.httpBody = body
        }
        
        // HTTP Headers
        for value in resource.headers {
            request.addValue(value.value.rawValue, forHTTPHeaderField: value.key.rawValue)
        }

        dump(request.url)
        dump(request.allHTTPHeaderFields)
        if let data = request.httpBody {
            dump(String(decoding: data, as: UTF8.self))
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.network(error: error.localizedDescription)))
                    debugPrint(error.localizedDescription)
                }
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200 ... 299:
                    if let data = data {
                        dump(String(decoding: data, as: UTF8.self))
                        let model = try? JSONDecoder().decode(T.self, from: data)
                        if let model = model {
                            DispatchQueue.main.async {
                                completion(.success(model))
                            }
                        } else {
                            // TODO: Handle msg that presents to user and load data to Firebase of error
                            DispatchQueue.main.async {
                                completion(.failure(.decoding(error: "Decode error")))
                            }
                        }
                    }
                default:
                    DispatchQueue.main.async {
                        debugPrint(response.statusCode)
                        debugPrint(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))
                        completion(.failure(.server(error: HTTPURLResponse.localizedString(forStatusCode: response.statusCode))))
                    }
                }
            }
        }.resume()
    }
}
