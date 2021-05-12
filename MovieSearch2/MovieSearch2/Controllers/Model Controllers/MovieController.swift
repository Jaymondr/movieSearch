//
//  MovieController.swift
//  MovieSearch2
//
//  Created by Jaymond Richardson on 5/8/21.
//

import UIKit

class MovieController {
    
    //MARK: - String Constants
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    static let apiKeyKey = "bbca093000db1980101279f71f6496f7"
    static let apiKeyName = "api_key"
    static let queryName = "query"
    static let posterImageURL = URL(string: "https://image.tmdb.org/t/p/w500")
    
    //MARK: - Fetch Functions
    
    static func fetchMovies(searchTerm: String, completion: @escaping (Result<[MovieDetails], MovieError>)-> Void ) {
        
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let apiQueryItem = URLQueryItem(name: apiKeyName, value: apiKeyKey)
        let movieSearchQuery = URLQueryItem(name: queryName, value: searchTerm)
        
        components?.queryItems = [apiQueryItem, movieSearchQuery]
        
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse{
                print("FETCH MOVIES STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let movieDetails = topLevelObject.results
                completion(.success(movieDetails))
                
            } catch {
                completion(.failure(.unableToDecode))
            }
            
        }.resume()
    }//End of function
    
    static func fetchPosterImage(movie: MovieDetails, completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        
        guard let posterURL = posterImageURL else {return completion(.failure(.invalidURL))}
        print(posterURL)
        
        guard let poster_path = movie.poster_path else {return}
        //        var imagePath = movie.poster_path
        let finalURL = posterURL.appendingPathComponent(poster_path) //JWR
        print(finalURL)
        //        let finalURL = posterURL.appendingPathComponent(posterImageURL)
        
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse{
                print("Poster status code: \(response.statusCode)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            guard let poster = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            completion(.success(poster))
            
        }.resume()
    }
}//End of class
