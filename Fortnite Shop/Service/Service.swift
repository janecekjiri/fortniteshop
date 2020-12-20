//
//  Service.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 10/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class Service {
    private let apiKey = "d162e8f4-7dfb5de9-3e284b5c-c82a4923"
    static let shared = Service()

    private func fetch<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        let session = URLSession.shared

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(apiKey, forHTTPHeaderField: "Authorization")

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(nil)
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            do {
                let dailies = try JSONDecoder().decode(T.self, from: data)
                completion(dailies)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }

    func fetchDailyShop(completion: @escaping (DailyShopModel?) -> Void) {
        guard let url = URL(string: "https://fortniteapi.io/v1/shop?lang=en") else {
            return
        }
        fetch(url: url, completion: completion)
    }

    func fetchItemDetail(for identity: String, completion: @escaping (ItemDetail?) -> Void) {
        guard let url = URL(string: "https://fortniteapi.io/v1/items/get?id=\(identity)&lang=en") else {
            return
        }
        fetch(url: url, completion: completion)
    }

    func fetchItemDetail(for item: ItemDetailProtocol, completion: @escaping (ItemDetail?) -> Void) {
        fetchItemDetail(for: item.identity, completion: completion)
    }

    func fetchImage(url: String, completion: @escaping (UIImage?) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(nil)
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }

}
