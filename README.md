## Project Setup Instructions:


1. clone the Repository
   > Use `git clone https://github.com/sudeepa88/BattleBucks.git`
   >  Then write `cd BattleBucks`
2. Double click on .xcodeproj
3. Make Sure your development environment matches the requirements below.


## iOS & Xcode Version Used:
  - **iOS Version:** 18.5
  - **Xcode Version:** 16.4
  - **Language:** Swift 6.1.2
  - **Framework:** SwiftUI

## Architecture - MVVM
The app follows the Model–View–ViewModel (MVVM) pattern for clean separation of concerns:
- **Model:** Defines data structures (e.g., UserPostModel, FavoritePost) and handles JSON decoding.
- **ViewModel:** Manages business logic and API communication (UserPostViewModel, UserPostAPICaller). Uses @Published properties to update the UI reactively.
- **View:** Declares the UI using SwiftUI views (ShowingList, FavoritesScreen, PostDetailView). Reacts automatically to ViewModel changes via @StateObject or @ObservedObject.

## Features Overview:
- Fetch Data from remote API
- Search Post by Title
- Mark/unmark favorites (stored in UserDefaults)
- Pull to refresh
- Floating button to view favorites
- Smooth navigation between Post List, Detail, and Favorites screens
