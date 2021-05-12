//
//  MovieTableViewCell.swift
//  MovieSearch2
//
//  Created by Jaymond Richardson on 5/8/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    //MARK: - Properties
    var movie: MovieDetails? {
        didSet {
            updateViews()
        }
    }
    
    
    
    //MARK: - Functions
    
    func updateViews() {
        guard let movie = movie else {return}
        titleLabel.text = movie.title
        ratingsLabel.text = "\(movie.vote_average)"
        descriptionLabel.text = movie.overview
        
        
        MovieController.fetchPosterImage(movie: movie) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let poster):
                    self.posterImageView.image = poster
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    override func prepareForReuse() {
        posterImageView.image = UIImage(systemName: "questionmark")
        
    }
}
