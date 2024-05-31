//
//  CharacterDetailsViewModel.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 31.05.24.
//

import Foundation
import SimpleNetworking

final class CharacterDetailsViewModel: ObservableObject {
    // MARK: Properties
    @Published var passedCharacter: CharacterInfoModel.Result?
    @Published var episodes: [EpisodeInfoModel] = []

    // MARK: Initialization
    init(passedCharacter: CharacterInfoModel.Result?) {
        self.passedCharacter = passedCharacter
        fetchEpisodes()
    }

    // MARK: Functions
    private func fetchEpisodes() {
        guard let episodeURLs = passedCharacter?.episode else {
            print("No episodes found")
            return
        }

        var fetchedEpisodes: [EpisodeInfoModel] = []
        let group = DispatchGroup()

        for urlString in episodeURLs {
            group.enter()
            WebService().fetchData(from: urlString, resultType: EpisodeInfoModel.self) { result in
                switch result {
                case .success(let episode):
                    fetchedEpisodes.append(episode)
                case .failure(let error):
                    print("Error fetching episode: \(error)")
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.episodes = fetchedEpisodes
        }
    }
}
