//
//  Service.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case urlWithBadFormat
    case callFailed
    case noData
    case badStatusCode
    case failedToDecode
}

protocol NetworkProtocol {
    func fetch<Object: Decodable>(from url: URL, completion: @escaping (Result<Object, ServiceError>) -> ())
}

struct Network: NetworkProtocol {

    func fetch<Object: Decodable>(from url: URL, completion: @escaping (Result<Object, ServiceError>) -> ()) {

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.callFailed))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }

            guard let httpStatus = response as? HTTPURLResponse ,
                (200..<300).contains(httpStatus.statusCode) else {
                    DispatchQueue.main.async {
                        completion(.failure(.badStatusCode))
                    }
                    return
            }

            guard let object = try? JSONDecoder().decode(Object.self, from: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.failedToDecode))
                }
                return
            }

            DispatchQueue.main.async {
                completion(.success(object))
            }
        }.resume()
    }
}
