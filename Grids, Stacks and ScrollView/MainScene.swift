//
//  MainScene.swift
//  Grids, Stacks and ScrollView
//
//  Created by Luka Gujejiani on 30.05.24.
//

import SwiftUI

struct MainScene: View {
    // MARK: Properties
    @State private var selectedTab = 0
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                CharacterView()
                    .tag(0)
                SearchView()
                    .tag(1)
                EpisodeView()
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            CustomTabBar(selectedTab: $selectedTab, tabBarItems: [
                TabBarItem(title: "Characters", imageName: "person.fill"),
                TabBarItem(title: "Search", imageName: "magnifyingglass"),
                TabBarItem(title: "Episodes", imageName: "play.circle.fill")
            ])
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: - Preview
struct MainScene_Previews: PreviewProvider {
    static var previews: some View {
        MainScene()
    }
}

// MARK: - Tab Bar
struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let tabBarItems: [TabBarItem]
    
    var body: some View {
        HStack {
            ForEach(0..<3) { index in
                VStack {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(selectedTab == index ? .green : .clear)
                    Image(systemName: tabBarItems[index].imageName)
                        .font(.system(size: 24))
                        .foregroundColor(selectedTab == index ? .green : .gray)
                        .padding(.top, 2)
                    Text(tabBarItems[index].title)
                        .font(.system(size: 12))
                        .foregroundColor(selectedTab == index ? .green : .gray)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .onTapGesture {
                    withAnimation {
                        selectedTab = index
                    }
                }
            }
        }
    }
}

struct TabBarItem {
    let title: String
    let imageName: String
}
