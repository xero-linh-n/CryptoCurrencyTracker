//
//  CoinListViewModel.swift
//  CryptoCurrencyTracker
//
//  Created by Linh Nguyen on 29/11/21.
//

import Foundation
import Combine
import SwiftUI

class CoinListViewModel: ObservableObject {
    
    @Published var coinViewModels = [CoinViewModel]()
    
    private let cryptoService = NetworkService()
    
    var cancellable: AnyCancellable?
    
    // Subscribe with sink, and map it
    // This does not use a operator, but grabs the raw published network request data
    // Map it to our array of ViewModels, and the view will re-render as it is observing our CoinListViewModel
    func fetchData() {
        cancellable = self.cryptoService.fetchData().sink(receiveCompletion: { _ in },
        receiveValue: { value in
            self.coinViewModels = value.data.coins.map { CoinViewModel($0) }
        })
    }
}
    

struct CoinViewModel: Hashable {
    
    private let coin: Coin
    
    init(_ coin: Coin) {
        self.coin = coin
    }
    
    var name: String {
        return coin.name
    }
    
    var formattedPrice: String {
        return coin.price
    }
}
