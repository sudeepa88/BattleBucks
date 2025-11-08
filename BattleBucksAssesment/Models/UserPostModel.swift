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
