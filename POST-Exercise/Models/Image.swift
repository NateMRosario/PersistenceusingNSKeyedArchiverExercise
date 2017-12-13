//
//  Image.swift
//  POST-Exercise
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class ImageInfo: Codable {
    let hits: [Image]
}
class Image: Codable {
    let likes: Int
    let favorites: Int
    let tags: String
    let downloads: Int
    let previewURL: String
    init(likes: Int, favorites: Int, tags: String, downloads: Int, previewURL: String) {
        self.likes = likes
        self.favorites = favorites
        self.tags = tags
        self.downloads = downloads
        self.previewURL = previewURL
    }
}
//enum HTTPVerb: String {
//    case GET
//    case POST
//}
struct ImagesAPIClient {
    private init() {}
    static let manager = ImagesAPIClient()
    func getImage(from urlStr: String , completionHandler: @escaping ([Image]) -> Void, errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let imageInfo = try JSONDecoder().decode(ImageInfo.self, from: data)
                completionHandler(imageInfo.hits)
            } catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}







