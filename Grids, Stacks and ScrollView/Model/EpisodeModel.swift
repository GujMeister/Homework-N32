//
//  EpisodeModel.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 31.05.24.
//

import Foundation

struct EpisodeInfo: Codable {
    let results: [EpisodeResult]
}

struct EpisodeResult: Codable, Identifiable {
    var id: Int
    let name, episode: String
    let characters: [String]
}
