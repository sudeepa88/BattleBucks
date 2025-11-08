//
//  DetailPage.swift
//  BattleBucksAssesment
//
//  Created by Sudeepa Pal on 03/10/25.
//

import SwiftUI

struct PostDetailView: View {
    let post: UserPostModel
    @ObservedObject var vm: UserPostViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(post.title ?? "No Title")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.lightViolet)
            Text(post.body ?? "No Content")
                .font(.body)
                .foregroundColor(.gray)
            Spacer()
            floatingFavoritesButton(post: post)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.black)
    }

    private func floatingFavoritesButton(post: UserPostModel) -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    vm.toggleFavorite(post: post)
                }) {
                    Image(systemName: vm.isFavorite(post: post) ? "heart.fill" : "heart")
                        .foregroundColor(vm.isFavorite(post: post) ? Color(#colorLiteral(red: 0.7647058824, green: 0.7019607843, blue: 0.9333333333, alpha: 1)) : .gray)
                        .font(.system(size: 24))
                        .padding()
                        .background(Color(#colorLiteral(red: 0.7098039216, green: 0.8117647059, blue: 0.9725490196, alpha: 1)).opacity(0.2))
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding()
            }
        }
    }
    
    
}

#Preview {
    PostDetailView(post: UserPostModel(userId: 6, id: 9, title: "No Name", body: "Some Details"), vm: UserPostViewModel())
}
