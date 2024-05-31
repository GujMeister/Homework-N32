//
//  SearchCharacterModel.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 31.05.24.
//

import Foundation

final class SearchCharacterInfo {
    struct CharacterInfo: Codable {
        let results: [CharacterResult]
    }
    
    struct CharacterResult: Codable, Identifiable {
        var id: Int
        var name: String
        var status: String
        var image: String
    }
}
