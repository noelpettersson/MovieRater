import Foundation

class MovieService {
    let apiKey = "7b673c7b08debe701cafd666de44fe7b"
    
    func searchMovieTitle(query: String, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&api_key=\(apiKey)&append_to_response=videos") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                    completion(.success(movieResponse))
                } catch {
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "Network", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed searching for movie"])
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(apiKey)") else {
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
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let movie = try decoder.decode(Movie.self, from: data)
                    completion(.success(movie))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    func fetchMovie() {
        // You can implement fetching specific movie details using the movie ID here
    }

}
