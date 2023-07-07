//
//  CoinRowItemView.swift
//  SwiftCoin
//
//  Created by Pulkit Dhirana on 05/07/23.
//

import SwiftUI
import Kingfisher

struct CoinRowItemView: View {
    let coin : CoinModel
    
    var body: some View {
        HStack {
            // market cap rank
            Text("\(coin.marketCapRank)")
                .font(.caption)
                .foregroundColor(.gray)
            
            // image
            KFImage(URL(string: coin.image))
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundColor(.orange)
            
            // coin name info
            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading, 4)
                
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .padding(.leading, 6)

            }
            .padding(.leading, 2)
            
            Spacer()

            // coin price info
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(coin.currentPrice.toCurrency())
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading, 4)
                
                Text(coin.priceChangePercentage24H.toPercentString())
                    .font(.caption)
                    .padding(.leading, 6)
                    .foregroundColor(coin.priceChangePercentage24H > 0 ? .green : .red)

            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)

    }
}

//struct CoinRowItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinRowItemView()
//    }
//}
