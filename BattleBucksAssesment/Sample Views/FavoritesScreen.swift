//
//  FavoritesScreen.swift
//  BattleBucksAssesment
//
//  Created by Sudeepa Pal on 03/10/25.
//

import SwiftUI

struct FavoritesScreen: View {
    @StateObject private var vm = UserPostViewModel()
    


    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.black.ignoresSafeArea()
                
                VStack {
                    if vm.favoritePosts.isEmpty {
                        Text("No favorites yet")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        List(vm.favoritePosts) { post in
                            HStack {
                                Text(post.title)
                                    .foregroundColor(.white)
                                Spacer()
                                Button(action: {
                                    vm.toggleFavorite(post: UserPostModel(userId: nil, id: post.id, title: post.title, body: nil))
                                }) {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.lightViolet)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            .listRowBackground(Color.gray.opacity(0.3)) // rows black
                        }
                        .scrollContentBackground(.hidden) // hides default list bg
                    }
                }
                .navigationBarTitle(Text("Favourites"))
                .navigationBarTitleDisplayMode(.inline)
                
                .onAppear {
                    vm.loadFavorites()
                }
            }

        }
    }
}
#Preview {
    FavoritesScreen()
}
