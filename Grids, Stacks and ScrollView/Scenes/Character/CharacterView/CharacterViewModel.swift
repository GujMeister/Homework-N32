//
//  CharacterViewModel.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 30.05.24.
//

import Foundation
import SimpleNetworking

final class CharacterViewModel: ObservableObject {
    // MARK: - Properties
    @Published var allCharacters: [CharacterInfoModel.Result] = []
    private var numberOfCharacterPages: Int?
    
    // MARK: - Initializer
    init() {
        fetchCharacterPages()
    }
    
    // MARK: - Functions
    private func fetchCharacterPages() {
        WebService().fetchData(from: "https://rickandmortyapi.com/api/character", resultType: PageModel.PageModel.self) { [weak self] data in
            switch data {
            case .success(let pageModel):
                self?.numberOfCharacterPages = pageModel.info?.pages
                self?.fetchAllCharacters()
            case .failure(let error):
                print("Error fetching page info: \(error)")
            }
        }
    }
    
    private func fetchAllCharacters() {
        guard let totalPages = numberOfCharacterPages else { return }
        
        let dispatchGroup = DispatchGroup()
        
        for page in 1...totalPages {
            dispatchGroup.enter()
            let urlString = "https://rickandmortyapi.com/api/character?page=\(page)"
            WebService().fetchData(from: urlString, resultType: CharacterInfoModel.characterInfo.self) { [weak self] data in
                switch data {
                case .success(let pageModel):
                        DispatchQueue.main.async {
                            self?.allCharacters.append(contentsOf: pageModel.results)
                        }
                case .failure(let error):
                    print("Error fetching characters from page \(page): \(error)")
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("All characters fetched successfully.")
        }
    }
}
