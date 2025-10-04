//
//  ShowingList.swift
//  BattleBucksAssesment
//
//  Created by Sudeepa Pal on 03/10/25.
//

import SwiftUI

struct ShowingList: View {
    @StateObject private var vm = UserPostViewModel()
    @State private var showFavorites = false
    @State private var searchText: String = ""
    
    
    var filteredPosts: [UserPostModel] {
        if searchText.isEmpty {
            return vm.userPostStack
        } else {
            return vm.userPostStack.filter { post in
                post.title?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        }
    }
    
    var body: some View {
        NavigationView {
            
            
            ZStack {
                Group {
                    if vm.isLoading {
                        ProgressView()
                    } else if let error = vm.errorMessage {
                        VStack(spacing: 12) {
                            Text("Error: \(error)")
                                .foregroundColor(.red)
                            Button("Retry") {
                                vm.getData {}
                            }
                        }
                    } else {
                        List(filteredPosts) { product in
                            
                            
                            HStack {
                                // Navigation to detail
                                NavigationLink(destination: PostDetailView(post: product)) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("User Id: \(product.userId ?? -1)") // coalescing
                                            .bold()
                                            .foregroundColor(.gray)
                                        
                                        Text(product.title ?? "No Title")
                                            .foregroundColor(.white)
                                            .lineLimit(2)
                                    }
                                    
                                    Button(action: {
                                        vm.toggleFavorite(post: product)
                                    }) {
                                        Spacer()
                                        Image(systemName: vm.isFavorite(post: product) ? "heart.fill" : "heart")
                                            .foregroundColor(vm.isFavorite(post: product) ? Color(#colorLiteral(red: 0.7647058824, green: 0.7019607843, blue: 0.9333333333, alpha: 1)) : .gray)
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                            }
                            .listRowBackground(Color.black)
                        }
                        .scrollContentBackground(.hidden)
                        
                        .refreshable {
                            vm.getData {}
                        }
                        .searchable(text: $searchText, prompt: "Search by title")
                        .tint(.white)
                        
                    }
                }
                .background(Color.black)
                //.navigationTitle("Posts")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Posts")
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                }
                .toolbarBackground(.black, for: .navigationBar)
                // Floating button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showFavorites = true
                        }) {
                            Image(systemName: "suit.heart.fill")
                                .font(.system(size: 24))
                                .foregroundColor(Color(#colorLiteral(red: 0.7098039216, green: 0.8117647059, blue: 0.9725490196, alpha: 1)))
                                .padding()
                                .background(Color(#colorLiteral(red: 0.7098039216, green: 0.8117647059, blue: 0.9725490196, alpha: 1)).opacity(0.2))
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding()
                        
                        NavigationLink(
                            destination: FavoritesScreen(),
                            isActive: $showFavorites
                        ) {
                            EmptyView()
                        }
                    }
                }
            }
            
            
        }
        
        .onAppear {
            if vm.userPostStack.isEmpty {
                vm.getData {}
            }
        }
        
        .background {
            Color.black
            
        }
        
    }
    
}

#Preview {
    ShowingList()
}
