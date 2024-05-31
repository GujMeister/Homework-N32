//
//  CharacterDetailsView.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 31.05.24.
//

import SwiftUI

struct CharacterDetailsView: View {
    // MARK: Properties
    let character: CharacterInfoModel.Result
    @StateObject var viewModel: CharacterDetailsViewModel
    
    // MARK: Init
    init(character: CharacterInfoModel.Result) {
        self.character = character
        _viewModel = StateObject(wrappedValue: CharacterDetailsViewModel(passedCharacter: character))
    }
    
    // MARK: - View
    var body: some View {
        VStack {
            Text(character.name)
                .font(.custom("GetSchwifty-Regular", size: 32))
                .padding()
                .multilineTextAlignment(.center)
            
            ScrollView(.vertical) {
                VStack {
                    AsyncImage(url: URL(string: character.image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 300)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: 20,
                                        bottomLeadingRadius: 0,
                                        bottomTrailingRadius: 0,
                                        topTrailingRadius: 20
                                    )
                                )
                            
                        case .failure:
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                                .foregroundColor(.red)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(LinearGradient(colors: [Color(hex: "#88e23b"), Color(hex: "#043c6e")], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 0,
                                    bottomLeadingRadius: 20,
                                    bottomTrailingRadius: 20,
                                    topTrailingRadius: 0
                                )
                            )
                        
                        VStack {
                            Text("Character Info:")
                                .font(.custom("FiraGO-Bold", size: 22))
                                .foregroundColor(Color(UIColor.label))
                                .padding(.top, -5)
                            
                            CharacterInfoView(character: character)
                            
                            Spacer()
                        }
                        .padding()
                    }
                    .padding(.top, -16)
                    
                    // MARK: - Episodes List
                    LazyVStack(alignment: .leading, spacing: 10) {
                        Text("Episodes starred in:")
                            .font(.title)
                            .bold()
                            .padding([.top, .bottom], 10)
                        
                        ForEach(viewModel.episodes, id: \.episode) { episode in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(episode.name)
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                    Text(episode.episode)
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                }
                                
                                Spacer()
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            
                            Spacer()
                        }
                        .padding(.vertical, -5)
                    }
                    .padding(.horizontal, -5)
                    
                    Spacer()
                }
                .padding([.horizontal, .bottom])
                .padding(.top, 0)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Character Info View
struct CharacterInfoView: View {
    let character: CharacterInfoModel.Result
    
    var body: some View {
        VStack {
            CharacterInfoRow(title: "Name:", value: character.name)
            CharacterInfoRow(title: "Status:", value: character.status)
            CharacterInfoRow(title: "Species:", value: character.species)
            CharacterInfoRow(title: "Gender:", value: character.gender)
            CharacterInfoRow(title: "Origin:", value: character.origin.name)
            CharacterInfoRow(title: "Location:", value: character.location.name)
        }
    }
}

struct CharacterInfoRow: View {
    let title: String
    let value: String?
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom("FiraGO-Regular", size: 16))
                .foregroundColor(Color(UIColor.label))
            Spacer()
            Text(value ?? "Unknown")
                .font(.custom("FiraGO-Bold", size: 16))
                .foregroundColor(Color(UIColor.label))
        }
        .padding(.horizontal, 2)
        .padding(.vertical, 2)
    }
}

