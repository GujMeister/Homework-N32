//
//  EpisodeView.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 31.05.24.
//

import SwiftUI

struct EpisodeView: View {
    // MARK: - Properties
    @StateObject var viewModel = EpisodeViewModel()
    let columns = [GridItem(.flexible())]
    
    // MARK: - View
    var body: some View {
        VStack {
            HStack {
                Text("Episodes")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.allEpisodes, id: \.name) { episode in
                        HStack {
                            VStack(alignment: .leading) {
                                    Text(episode.name)
                                        .font(.headline)
                                        .lineLimit(1)
                                        .cornerRadius(8)

                                    Text(episode.episode)
                                        .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(20)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    EpisodeView()
}
