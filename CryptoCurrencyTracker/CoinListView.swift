//
//  ContentView.swift
//  CryptoCurrencyTrackerApp
//
//  Created by Linh Nguyen on 29/11/21.
//

import SwiftUI

// Start off by builing CoinList ContentView
// Build out the ViewModels
// The CryptoCurrency Service to pull data from Public API

struct CoinListView: View {
    @ObservedObject private var viewModel = CoinListViewModel()
    var body: some View {
        VStack {
            Text("Crypto Prices").font(.title)
            List(viewModel.coinViewModels, id: \.self) { coinViewModel in
                Text("\(coinViewModel.name)" + " \(coinViewModel.formattedPrice)")
            }.onAppear {
                self.viewModel.fetchData()
            }
        }
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinListView()
    }
}
