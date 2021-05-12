//
//  Movie.swift
//  MovieSearch2
//
//  Created by Jaymond Richardson on 5/8/21.
//

import Foundation
import UIKit
/* URLS
 
 Base URL:
 https://api.themoviedb.org/3/search/movie?api_key=<<API KEY>>&query=<<keyword>>
 
 Config data (images):
 "https://image.tmdb.org/t/p/w500"
 
 API Key
 https://api.themoviedb.org/3/movie/550?api_key=bbca093000db1980101279f71f6496f7
 
 */





struct TopLevelObject: Codable {
    let results: [MovieDetails]
}

struct MovieDetails: Codable {
    let title: String
    let overview: String
    let vote_average: Double
    let poster_path: String?
    
}
