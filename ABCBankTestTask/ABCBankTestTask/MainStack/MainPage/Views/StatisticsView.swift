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
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Statistics")
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(statistics.pageStats, id: \.pageNumber) { pageStat in
                        Text("Page \(pageStat.pageNumber) (\(pageStat.itemCount) items)")
                            .font(.body)
                    }
                }
                
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Top 3 Characters")
                        .font(.headline)
                    
                    ForEach(statistics.topCharacters, id: \.character) { charStat in
                        Text("\(String(charStat.character)) = \(charStat.count)")
                            .font(.body)
                    }
                }
            }
            .padding()
        }
        .presentationDetents([.medium])
    }
    
}
