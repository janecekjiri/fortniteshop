//
//  Service.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 10/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import Foundation

class Service {
    let apiKey = "d162e8f4-7dfb5de9-3e284b5c-c82a4923"
    static let shared = Service()

    func fetchDailyShop() {
        let session = URLSession.shared
        guard let url = URL(string: "https://fortniteapi.io/v1/shop?lang=en") else {
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(apiKey, forHTTPHeaderField: "Authorization")

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("We have encountered error right at the beginning! \(error)")
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                print("Status code is not withing the range 200-299")
                return
            }

            guard let data = data else {
                return
            }

            do {
                let dailies = try JSONDecoder().decode(DailyShopModel.self, from: data)
                print(dailies)
            } catch {
                print("We were not able to decode the data into JSON")
            }
        }
        task.resume()
    }
}
