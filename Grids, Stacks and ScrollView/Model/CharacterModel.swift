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
    
    struct Result: Decodable, Identifiable {
        let id: Int
        var name: String
        let status: String
        let species: String
        let gender: String
        let origin, location: Location
        let image: String
        let episode: [String]
    }
    
    struct Location: Decodable {
        let name: String
    }
}
