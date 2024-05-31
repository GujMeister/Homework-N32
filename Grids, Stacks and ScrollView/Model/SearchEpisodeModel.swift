//
//  SearchEpisodeModel.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 31.05.24.
//

import Foundation

final class SearchEpisodeInfo {
    struct EpisodeInfo: Codable {
        let results: [EpisodeResult]
    }
    
    struct EpisodeResult: Codable, Identifiable {
        var id: Int
        var name: String
        var episode: String
        var characters: [String]
    }
}
