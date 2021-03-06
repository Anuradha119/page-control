//
//  movies.swift
//  imagesview
//
//  Created by Marni Anuradha on 12/12/19.
//  Copyright © 2019 Marni Anuradha. All rights reserved.
//

import Foundation

struct movies : Codable {



        let actors : [String]?

        let director : String?

        let posters : [String]?

        let songs : [String]?

        let story : String?

        let title : String?

        let trailers : [String]?



        enum CodingKeys: String, CodingKey {

                case actors = "actors"

                case director = "director"

                case posters = "posters"

                case songs = "songs"

                case story = "story"

                case title = "title"

                case trailers = "trailers"

        }

    

        init(from decoder: Decoder) throws {

                let values = try decoder.container(keyedBy: CodingKeys.self)

                actors = try values.decodeIfPresent([String].self, forKey: .actors)

                director = try values.decodeIfPresent(String.self, forKey: .director)

                posters = try values.decodeIfPresent([String].self, forKey: .posters)

                songs = try values.decodeIfPresent([String].self, forKey: .songs)

                story = try values.decodeIfPresent(String.self, forKey: .story)

                title = try values.decodeIfPresent(String.self, forKey: .title)

                trailers = try values.decodeIfPresent([String].self, forKey: .trailers)

        }



}

