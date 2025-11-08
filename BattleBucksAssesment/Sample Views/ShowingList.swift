import SwiftUI

struct ShowingList: View {
    @StateObject private var vm = UserPostViewModel()
    @State private var searchText: String = ""
    @State private var debouncedSearchText: String = ""

    var filteredPosts: [UserPostModel] {
        filterPosts(vm.userPostStack, with: debouncedSearchText)
    }
    
    private func filterPosts(_ posts: [UserPostModel], with query: String) -> [UserPostModel] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return posts }
        return posts.filter { post in
            let title = post.title ?? ""
            return title.localizedCaseInsensitiveContains(trimmed)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                contentGroup
                floatingFavoritesButton
            }
        }
        .onAppear(perform: onAppear)
        .background { Color.black }
        .onChange(of: searchText) {
            Task { @MainActor in
                let current = searchText
                try? await Task.sleep(nanoseconds: 500_000_000)
                if current == searchText {
                    debouncedSearchText = current
                }
            }
        }
    }

    // MARK: - Content Sections
    private var contentGroup: some View {
        Group {
            if vm.isLoading {
                loadingView
            } else if let error = vm.errorMessage {
                errorView(error)
            } else {
                listView
            }
        }
        .background(Color.black)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { toolbarTitle }
        .toolbarBackground(.black, for: .navigationBar)
        .tint(.white)
    }

    private var loadingView: some View {
        ProgressView()
    }

    private func errorView(_ message: String) -> some View {
        VStack(spacing: 12) {
            Text("Error: \(message)")
                .foregroundColor(.red)
            Button("Retry") { vm.getData({}) }
        }
    }

    @ViewBuilder
    private var listView: some View {
        List(filteredPosts) { product in
            listRow(for: product)
                .listRowBackground(Color.black)
        }
        .scrollContentBackground(.hidden)
        .refreshable { vm.getData({}) }
        .searchable(text: $searchText, prompt: "Search by title")
    }

    private func listRow(for product: UserPostModel) -> some View {
        HStack {
            NavigationLink(destination:
                            PostDetailView(post: product, vm: vm)
                .navigationTitle("Detail")
                .navigationBarTitleDisplayMode(.inline)
            ) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("User Id: \(product.userId ?? -1)")
                            .bold()
                            .foregroundColor(.gray)
                        Text(product.title ?? "No Title")
                            .foregroundColor(.white)
                            .lineLimit(2)
                    }
                    Spacer()
                    favoriteButton(for: product)
                }
            }
        }
    }

    private func favoriteButton(for product: UserPostModel) -> some View {
        Button(action: { vm.toggleFavorite(post: product) }) {
            Image(systemName: vm.isFavorite(post: product) ? "heart.fill" : "heart")
                .foregroundColor(vm.isFavorite(post: product) ? Color(#colorLiteral(red: 0.7647058824, green: 0.7019607843, blue: 0.9333333333, alpha: 1)) : .gray)
        }
        .buttonStyle(BorderlessButtonStyle())
    }

    private var toolbarTitle: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            VStack {
                Text("Posts")
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }

    // MARK: - Floating Button
    private var floatingFavoritesButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(
                    destination: FavoritesScreen(vm: vm)
                        .navigationTitle("Favourites")
                        .navigationBarTitleDisplayMode(.inline)
                ) {
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color(#colorLiteral(red: 0.7098039216, green: 0.8117647059, blue: 0.9725490196, alpha: 1)))
                        .padding()
                        .background(Color(#colorLiteral(red: 0.7098039216, green: 0.8117647059, blue: 0.9725490196, alpha: 1)).opacity(0.2))
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding()
            }
        }
    }

    // MARK: - Lifecycle
    private func onAppear() {
        if vm.userPostStack.isEmpty { vm.getData({}) }
        debouncedSearchText = searchText
    }
}

#Preview {
    ShowingList()
}
