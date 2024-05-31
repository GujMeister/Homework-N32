//
//  EpisodeViewModel.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 31.05.24.
//

import Foundation
import SimpleNetworking

final class EpisodeViewModel: ObservableObject {
    // MARK: Properties
    private var numberOfEpisodePages: Int?
    @Published var allEpisodes: [EpisodeResult] = []
    
    // MARK: Initialization
    init() {
        fetchCharacterPages()
    }
    
    // MARK: Functions
    private func fetchCharacterPages() {
        WebService().fetchData(from: "https://rickandmortyapi.com/api/episode", resultType: PageModel.PageModel.self) { [weak self] data in
            switch data {
            case .success(let pageModel):
                self?.numberOfEpisodePages = pageModel.info?.pages
                self?.fetchAllCharacters()
            case .failure(let error):
                print("Error fetching page info: \(error)")
            }
        }
    }
    
    private func fetchAllCharacters() {
        guard let totalPages = numberOfEpisodePages else { return }
        
        let dispatchGroup = DispatchGroup()
        
        for page in 1...totalPages {
            dispatchGroup.enter()
            let urlString = "https://rickandmortyapi.com/api/episode?page=\(page)"
            WebService().fetchData(from: urlString, resultType: EpisodeInfo.self) { [weak self] data in
                switch data {
                case .success(let episodeInfo):
                        DispatchQueue.main.async {
                            self?.allEpisodes.append(contentsOf: episodeInfo.results)
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
