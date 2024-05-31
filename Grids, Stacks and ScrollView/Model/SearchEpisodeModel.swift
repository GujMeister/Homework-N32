//
//  SearchEpisodeModel.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 31.05.24.
//

import Foundation

final class SearchEpisodeInfo {
    struct EpisodeInfo: Decodable {
        let results: [EpisodeResult]
    }
    
    struct EpisodeResult: Decodable, Identifiable {
        var id: Int
        var name: String
        var episode: String
        var characters: [String]
    }
}
