//
//  CharacterView.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 30.05.24.
//
import SwiftUI

struct CharacterView: View {
    // MARK: Properties
    @StateObject var viewModel = CharacterViewModel()
    let columns = [GridItem(.adaptive(minimum: 150)), GridItem(.adaptive(minimum: 150))]
    
    // MARK: View
    var body: some View {
        NavigationStack {
            HStack {
                Text("Characters")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.allCharacters, id: \.name) { character in
                        NavigationLink(
                            destination: CharacterDetailsView(character: character)) {
                                GridCell(character: character)
                            }
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview
struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView()
    }
}

// MARK: - Character Cell
struct GridCell: View {
    let character: CharacterInfoModel.Result
    
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: URL(string: character.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(height: 150)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(
                            .rect(
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 0
                            )
                        )
                        .shadow(radius: 5)
                        .padding([.top, .horizontal], -16)
                case .failure:
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(character.name)
                .font(.custom("FiraGO-Bold", size: 14))
                .bold()
                .foregroundColor(Color(UIColor.black))
                .padding(.horizontal)
                .padding(.vertical, 5)
                .lineLimit(1)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
