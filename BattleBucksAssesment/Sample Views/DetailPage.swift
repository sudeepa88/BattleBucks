//
//  DetailPage.swift
//  BattleBucksAssesment
//
//  Created by Sudeepa Pal on 03/10/25.
//

import SwiftUI

struct PostDetailView: View {
    let post: UserPostModel
    
    var body: some View {
        ZStack {
            Color.black .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 12) {
                Text(post.title ?? "No Title")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.lightViolet)
                
                Text(post.body ?? "No Content")
                    .font(.body)
                    .foregroundColor(.gray)
                
                Spacer()
                
            } .padding()
        } //.navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { ToolbarItem(placement: .principal) {
            VStack {
                Text("Detail")
                    .bold()
                    .foregroundColor(.white)
            }
        }
        }
        .toolbarBackground(.black, for: .navigationBar)
    }
}
    
    
#Preview {
    PostDetailView(post: UserPostModel(userId: 6, id: 9, title: "No Name", body: "Some Details"))
}
