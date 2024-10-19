//
//  User.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/18/24.
//
//  https://github.com/ivansaul
//

import Foundation

struct User: Decodable {
    let id: Int
    let username: String
    let name: String
    let includeAdult: Bool
    let avatarURL: URL?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        name = try container.decode(String.self, forKey: .name)
        includeAdult = try container.decode(Bool.self, forKey: .includeAdult)

        let avatarContainer = try container.nestedContainer(keyedBy: AvatarCodingKeys.self, forKey: .avatar)
        let tmdbContainer = try avatarContainer.nestedContainer(keyedBy: TmdbCodingKeys.self, forKey: .tmdb)
        let avatarPath = try tmdbContainer.decodeIfPresent(String.self, forKey: .avatarPath)

        if let avatarPath {
            avatarURL = URL(string: APIConstants.apiImageBaseUrl + "/w500" + avatarPath)
        } else {
            avatarURL = nil
        }
    }

    enum CodingKeys: String, CodingKey {
        case id, username, name, includeAdult = "include_adult", avatar
    }

    enum AvatarCodingKeys: String, CodingKey {
        case tmdb
    }

    enum TmdbCodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}
