//
//  TvShow.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//


struct TvShow: Codable {
    var results: [Movie]
}

struct Movie: Codable {
    var overview: String
    var poster_path: String
    var release_date: String
    var title: String
    var media_type: String
    var vote_average: Float
}
