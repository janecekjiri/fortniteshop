//
//  Service.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 10/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class Service {
    let apiKey = "d162e8f4-7dfb5de9-3e284b5c-c82a4923"
    static let shared = Service()

    func fetchDailyShop(completion: @escaping (DailyShopModel?) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: "https://fortniteapi.io/v1/shop?lang=en") else {
            return
        }
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
                let dailies = try JSONDecoder().decode(DailyShopModel.self, from: data)
                completion(dailies)
            } catch {
                completion(nil)
            }
        }
        task.resume()
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

    func fetchItemDetail(for item: DailyShopItem, completion: @escaping (ItemDetailWrapper?) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: "https://fortniteapi.io/v1/items/get?id=\(item.identity)&lang=en") else {
            return
        }
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
                let dailies = try JSONDecoder().decode(ItemDetailWrapper.self, from: data)
                completion(dailies)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
}
