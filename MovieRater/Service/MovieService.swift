import Foundation

class MovieService {
    let apiKey = "7b673c7b08debe701cafd666de44fe7b"
    
    func searchMovieTitle(query: String, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&api_key=\(apiKey)&append_to_response=videos") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                    
                    // Print properties of each movie in the response
                    movieResponse.results.forEach { movie in
                        print("Movie ID: \(movie.id)")
                        print("Movie Title: \(movie.title)")
                        print("Movie Backdrop Path: \(movie.backdrop_path ?? "N/A")")
                        print("Movie Poster Path: \(movie.poster_path ?? "N/A")")
                        print("Movie Overview: \(movie.overview)")
                        print("Movie Vote Average: \(movie.vote_average)")
                        print("Movie Vote Count: \(movie.vote_count)")
                        print("Movie Runtime: \(movie.runtime ?? 0)")
                        print("Movie Release Date: \(movie.release_date ?? "N/A")")
                        print("Movie Genre: \(movie.genre ?? "N/A")")
                        print("Movie Origin Country: \(movie.origin_country ?? "N/A")")
                        print("--------------------------")
                    }
                    
                    completion(.success(movieResponse))
                } catch {
                    print("Search Movie Error: \(error)")
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "Network", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed searching for movie"])
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchMovieDetailsByID(id: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    completion(.success(movie))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchMovie() {
        // You can implement fetching specific movie details using the movie ID here
    }

}
