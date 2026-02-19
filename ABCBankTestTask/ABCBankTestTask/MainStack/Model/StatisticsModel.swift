//
//  StatisticsModel.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 11/02/2026.
//

struct StatisticsModel {
    let pagesStats: [PageStat]
    let topCharactersStats: [TopCharacterStat]
}

struct PageStat {
    let pageNumber: Int
    let itemCount: Int
}

struct TopCharacterStat {
    let character: Character
    let count: Int
}
