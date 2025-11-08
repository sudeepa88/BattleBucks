//
//  UserPostAPICaller.swift
//  BattleBucksAssesment
//
//  Created by Sudeepa Pal on 03/10/25.
//

import Foundation

class UserPostAPICaller {
    public static func getUserPostData(completion: @escaping (_ testResult: Result<[UserPostModel], Error>) -> Void) {
        
        //1. Converting String into an url
        let urlStr = NetworkConstants.shared.serverAddress
        guard let url = URL(string: urlStr) else {
            completion(.failure(Error.self as! Error))
            return
        }

        //2. URL Session task
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            //Assuming best case
            if error == nil, let daata = dataResponse, let jsonResponse = try? JSONDecoder().decode([UserPostModel].self, from: daata) {
                completion(.success(jsonResponse))
            } else {
                completion(.failure( error!))
            }
        }.resume()
        
    }
}
