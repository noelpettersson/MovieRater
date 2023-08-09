//
//  MovieView.swift
//  MovieRater
//
//  Created by Anders Pettersson on 2023-08-08.
//

import SwiftUI

struct MovieView: View {
    //let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Test movie")
                    .font(.title)
                    .bold()

                Text("Release Date: 2001/01/01")
                    .foregroundColor(.gray)

                Text("Genre: Action, Adventure") // Replace with actual genre data

                // Placeholder for movie poster image
                Image(systemName: "film")
                    .resizable()
                    .frame(width: 200, height: 300)
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                xx1
                Text("Overview:")
                    .font(.headline)
                    .padding(.top, 10)

                Text("Overview will be here")
                    .foregroundColor(.secondary)
                    .lineLimit(nil)
                
                Text("Origin Country: USA") // Replace with actual country data
                
                Text("Runtime: 120 minutes") // Replace with actual runtime data
            }
            .padding()
        }
    }
}
