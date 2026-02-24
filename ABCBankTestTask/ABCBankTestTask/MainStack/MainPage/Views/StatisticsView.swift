//
//  StatisticsView.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 12/02/2026.
//

import SwiftUI

struct StatisticsView: View {
    
    let statistics: StatisticsModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                Text("Statistics")
                    .font(.system(size: 24, weight: .bold))
                
                Spacer().frame(height: 16)
                
                // Page stats
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(statistics.pagesStats, id: \.pageNumber) { pageStat in
                        Text("Page \(pageStat.pageNumber) (\(pageStat.itemCount) items)")
                            .font(.system(size: 16))
                    }
                }
                
                Spacer().frame(height: 16)
                
                Rectangle()
                    .fill(Color(.separator))
                    .frame(height: 1)
                
                Spacer().frame(height: 16)
                
                Text("Top 3 Characters")
                    .font(.system(size: 18, weight: .bold))
                
                Spacer().frame(height: 8)
                
                // Top characters
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(statistics.topCharactersStats, id: \.character) { charStat in
                        Text("\(String(charStat.character)) = \(charStat.count)")
                            .font(.system(size: 16))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}
