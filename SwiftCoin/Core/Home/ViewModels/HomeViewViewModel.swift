//
//  HomeViewViewModel.swift
//  SwiftCoin
//
//  Created by Pulkit Dhirana on 06/07/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var coins = [CoinModel]()
    @Published var topMovingCoins = [CoinModel]()

    init() {
        fetchCoinData()
    }
    
    func fetchCoinData() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h&locale=en"
        
        guard let url = URL(string: urlString) else {
            return 
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DEBUG: Error \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("DEBUG: Response Code \(response.statusCode)")

            }
            
            guard let data = data else { return }
            
            
            do {
                let coins = try JSONDecoder().decode([CoinModel].self, from: data)
                
                DispatchQueue.main.async {
                    self.coins = coins
                    self.configureTopMovingCoins()
                }
                
            }
            catch let error {
                DispatchQueue.main.async {
                    print("DEBUG: Failed to decode with error: \(error)")
                }
            }

        }
        task.resume()
         
    }
    
    func configureTopMovingCoins() {
        let topMovers = coins.sorted(by: { $0.priceChangePercentage24H > $1.priceChangePercentage24H
        })
        self.topMovingCoins = Array(topMovers.prefix(5))
    }
}
