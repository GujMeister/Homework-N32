//
//  SearchView.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 31.05.24.
//

import SwiftUI

struct SearchView: View {
    // MARK: Properties
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText = ""
    @State private var searchOption = 0
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.green)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.cyan], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.green.opacity(0.4))
        }
    
    // MARK: View
    var body: some View {
        ZStack {
            VStack {
                Picker("Search Option", selection: $searchOption) {
                    Text("Search by Character").tag(0)
                    Text("Search by Episode").tag(1)
                }
                
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: searchOption) {
                    clearSearchResults()
                }
                
                if searchOption == 0 {
                    TextField("Search by character name...", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .onSubmit {
                            performSearch()
                        }
                } else {
                    TextField("Search by episode name...", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .onSubmit {
                            performSearch()
                        }
                }
                
                // MARK:  Search Results
                ScrollView {
                    if searchOption == 0 {
                        ForEach(viewModel.characters) { character in
                            CharacterCell(character: character)
                        }
                    } else {
                        ForEach(viewModel.episodes) { episode in
                            EpisodeCell(episode: episode)
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            
            if viewModel.episodes.isEmpty && viewModel.characters.isEmpty {
                Image("Rick-and-Morty")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
    // MARK:  Helper function
    func performSearch() {
        if searchOption == 0 {
            viewModel.searchCharacters(name: searchText)
        } else {
            viewModel.searchEpisodes(name: searchText)
        }
    }
    
    func clearSearchResults() {
        viewModel.characters.removeAll()
        viewModel.episodes.removeAll()
        searchText = ""
    }
}


// MARK: - Preview
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

// MARK: - Extracted Views: Cells
struct CharacterCell: View {
    var character: SearchCharacterInfo.CharacterResult
    
    var body: some View {
        LazyVStack {
            HStack {
                AsyncImage(url: URL(string: character.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 50, height: 50)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                            .clipShape(Circle())
                    case .failure:
                        Image(systemName: "xmark.circle")
                            .frame(width: 50, height: 50)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Spacer()
                
                VStack {
                    Text(character.name)
                        .font(.headline)
                    Text(character.status)
                        .font(.subheadline)
                }
                
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(radius: 5)
            )
            .padding(.horizontal)
        }
        .padding(.vertical, 5)
    }
}

struct EpisodeCell: View {
    var episode: SearchEpisodeInfo.EpisodeResult
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            Text(episode.name)
                .font(.headline)
                .padding([.horizontal, .top])
            Text(episode.episode)
                .font(.subheadline)
                .padding([.horizontal, .bottom])
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 5)
        )
        .padding(.horizontal)
    }
}
