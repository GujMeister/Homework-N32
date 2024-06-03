//
//  CharacterModel.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 30.05.24.
//

import Foundation

final class CharacterInfoModel {
    struct characterInfo: Decodable {
        let results: [Result]
    }
    
    struct Result: Decodable, Identifiable, Hashable {
        let id: Int
        var name: String
        let status: String
        let species: String
        let gender: String
        let origin, location: Location
        let image: String
        let episode: [String]
        
        // Conform to Equatable
        static func == (lhs: Result, rhs: Result) -> Bool {
            return lhs.id == rhs.id
        }
        
        // Conform to Hashable
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    struct Location: Decodable, Hashable {
        let name: String
    }
}
