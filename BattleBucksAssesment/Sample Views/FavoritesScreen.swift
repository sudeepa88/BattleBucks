//
//  FavoritesScreen.swift
//  BattleBucksAssesment
//
//  Created by Sudeepa Pal on 03/10/25.
//

import SwiftUI

struct FavoritesScreen: View {
    @ObservedObject var vm: UserPostViewModel

    var body: some View {
        content
            .onAppear(perform: onAppear)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .navigationTitle("Favourites")
            .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Content
    private var content: some View {
        Group {
            if vm.favoritePosts.isEmpty {
                emptyState
            } else {
                favoritesList
            }
        }
    }

    private var emptyState: some View {
        VStack {
            Text("No favorites yet")
                .foregroundColor(.gray)
                .padding()
        }
    }

    private var favoritesList: some View {
        List(vm.favoritePosts) { post in
            favoriteRow(for: post)
                .listRowBackground(Color.gray.opacity(0.3))
        }
        .scrollContentBackground(.hidden)
    }

    private func favoriteRow(for post: FavoritePost) -> some View {
        HStack {
            Text(post.title)
                .foregroundColor(.white)
            Spacer()
            Button(role: .destructive,
                   action: {
                vm.toggleFavorite(post: UserPostModel(
                    userId: post.userId,
                    id: post.id,
                    title: post.title,
                    body: post.body
                ))
            }
            ) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.lightViolet)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }

    // MARK: - Lifecycle
    private func onAppear() {
        vm.loadFavorites()
    }
}

#Preview {
    NavigationView { FavoritesScreen(vm: UserPostViewModel()) }
}

