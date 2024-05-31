//
//  CharacterPageModel.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 30.05.24.
//

import Foundation

final class PageModel {
    struct PageModel: Decodable {
        let info: Info?
    }
    
    struct Info: Decodable {
        let pages: Int?
    }
}
