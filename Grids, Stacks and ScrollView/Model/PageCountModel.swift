//
//  CharacterPageModel.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 30.05.24.
//

import Foundation

final class PageModel {
    struct PageModel: Codable {
        let info: Info?
    }
    
    struct Info: Codable {
        let pages: Int?
    }
}
