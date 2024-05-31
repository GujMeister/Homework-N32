//
//  EpisodeInfoModel.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 31.05.24.
//

import Foundation

struct EpisodeInfoModel: Decodable, Identifiable {
    var id: Int
    var name: String
    var episode: String
}
