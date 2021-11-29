//
//  NetworkService.swift
//  CryptoCurrencyTracker
//
//  Created by Linh Nguyen on 29/11/21.
//

import Foundation
import Combine

final class NetworkService {
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coinranking.com"
        components.path = "/v2/coins"
        components.queryItems = [URLQueryItem(name: "base", value: "USD"), URLQueryItem(name: "timePeriod", value:     "24h")]
        return components
    }
    
    // initiate a network fetch request, and return as a Publisher Type <AnyPublisher> for subscription
    func fetchData() -> AnyPublisher<DataResponse, Error> {
        URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { $0.data }
            .decode(type: DataResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct DataResponse: Decodable {
    let status: String
    let data: CryptoData
}

struct CryptoData: Decodable {
    let coins: [Coin]
}

struct Coin: Decodable, Hashable {
    let name: String
    let price: String
}
