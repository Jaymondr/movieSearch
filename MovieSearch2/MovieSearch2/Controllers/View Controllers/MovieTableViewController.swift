//
//  MovieTableViewController.swift
//  MovieSearch2
//
//  Created by Jaymond Richardson on 5/8/21.
//

import UIKit

class MovieTableViewController: UITableViewController {
    //MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        updateTableView()
        searchBar.delegate = self
        
        
    }
    //MARK: - Properties
    var movies: [MovieDetails] = []
    var movie: MovieDetails?
    
    
    //MARK: - Functions
    
    func updateTableView() {
        MovieController.fetchMovies(searchTerm: String()) { (result) in //JWR searchTerm string?
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                
                }
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell
        
        let movie = movies[indexPath.row]
        cell?.movie = movie
        
        return cell ?? MovieTableViewCell()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/5
        
    }
    
}
extension MovieTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        MovieController.fetchMovies(searchTerm: searchTerm.lowercased()) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let movie):
                    
                    self.movies = movie // reassigning SOT
                    self.tableView.reloadData() //Updating the table view after updating SOT
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    
                }
                
            }
        }
    }
}
