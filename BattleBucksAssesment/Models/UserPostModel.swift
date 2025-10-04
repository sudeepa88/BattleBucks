//
//  UserPostModel.swift
//  BattleBucksAssesment
//
//  Created by Sudeepa Pal on 03/10/25.
//

import Foundation


struct UserPostModel: Codable, Identifiable {
    let userId : Int?
    let id : Int?
    let title : String?
    let body : String?

    enum CodingKeys: String, CodingKey {

        case userId = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
    }
    
    //optional will remove it letter 
    init(userId: Int?, id: Int?, title: String?, body: String?) {
            self.userId = userId
            self.id = id
            self.title = title
            self.body = body
        }
    
    

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        body = try values.decodeIfPresent(String.self, forKey: .body)
    }

}


let dummyUserPosts: [UserPostModel] = [
    UserPostModel(userId: 1, id: 1, title: "SwiftUI Basics", body: "An introduction to building user interfaces with SwiftUI."),
    UserPostModel(userId: 1, id: 2, title: "Combine Framework", body: "Understanding how publishers and subscribers work together."),
    UserPostModel(userId: 2, id: 3, title: "Networking in iOS", body: "How to make API calls using URLSession and async/await."),
    UserPostModel(userId: 2, id: 4, title: "Core Data Guide", body: "Persisting data locally with Core Data in Swift."),
    UserPostModel(userId: 3, id: 5, title: "Animations in SwiftUI", body: "Adding smooth and interactive animations to your views."),
    UserPostModel(userId: 3, id: 6, title: "Dependency Injection", body: "Improving testability and modularity in your apps."),
    UserPostModel(userId: 4, id: 7, title: "Dark Mode Support", body: "Best practices for designing apps that adapt to system appearance."),
    UserPostModel(userId: 4, id: 8, title: "Swift Concurrency", body: "Using async/await and actors to handle concurrency safely."),
    UserPostModel(userId: 5, id: 9, title: "App Performance", body: "Tips and techniques to optimize your iOS applications."),
    UserPostModel(userId: 5, id: 10, title: "UI Testing", body: "Writing UI tests with XCTest for reliable app behavior.")
]


