//
//  SearchViewModel.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 31.05.24.
//

import Foundation
import SimpleNetworking

final class SearchViewModel: ObservableObject {
    // MARK: Properties
    @Published var characters: [SearchCharacterInfo.CharacterResult] = []
    @Published var episodes: [SearchEpisodeInfo.EpisodeResult] = []
    
    // MARK: Functions
    func searchCharacters(name: String) {
        let urlString = "https://rickandmortyapi.com/api/character/?name=\(name)"
        
        WebService().fetchData(from: urlString, resultType: SearchCharacterInfo.CharacterInfo.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let characterInfo):
                    self?.characters = characterInfo.results
                case .failure(let error):
                    print("Error fetching characters: \(error)")
                }
            }
        }
    }
    
    func searchEpisodes(name: String) {
        let urlString = "https://rickandmortyapi.com/api/episode/?name=\(name)"
        
        WebService().fetchData(from: urlString, resultType: SearchEpisodeInfo.EpisodeInfo.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let episodeInfo):
                    self?.episodes = episodeInfo.results
                case .failure(let error):
                    print("Error fetching episodes: \(error)")
                }
            }
        }
    }
}
