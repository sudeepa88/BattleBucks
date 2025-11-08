//
//  UserPostViewModel.swift
//  BattleBucksAssesment
//
//  Created by Sudeepa Pal on 03/10/25.
//

import Foundation
import SwiftUI




class UserPostViewModel: ObservableObject {
    @Published var userPostStack: [UserPostModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let favoritesKey = "favoritePosts"
    @Published var favoritePosts: [FavoritePost] = []
    
    init() {
        loadFavorites()
    }
    
    func getData(_ completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        UserPostAPICaller.getUserPostData { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
                    self.userPostStack = data
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.userPostStack = []
                }
                completion()
            }
        }
    }
    
    //MARK: All my storage functionality
    
    public func loadFavorites() {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let saved = try? JSONDecoder().decode([FavoritePost].self, from: data) else {
            favoritePosts = []
            return
        }
        favoritePosts = saved
    }
    
    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favoritePosts) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
    
    func isFavorite(post: UserPostModel) -> Bool {
        guard let id = post.id else { return false }
        return favoritePosts.contains { $0.id == id }
    }
    
    func toggleFavorite(post: UserPostModel) {
        guard let id = post.id, let title = post.title , let userId = post.userId, let body = post.body else { return }
        let favoritePost = FavoritePost(userId: userId, id: id, title: title, body: body)
        
        if let index = favoritePosts.firstIndex(of: favoritePost) {
            favoritePosts.remove(at: index)
        } else {
            favoritePosts.append(favoritePost)
        }
        saveFavorites()
        loadFavorites()
    }
}



//MARK: All my storage functionality
