//
//  FavoritePostModel.swift
//  BattleBucksAssesment
//
//  Created by Sudeepa Pal on 03/10/25.
//

import Foundation


struct FavoritePost: Codable, Equatable, Identifiable {
    let userId : Int
    let id : Int
    let title : String
    let body : String
}
