//
//  MainView.swift
//  MovieRater
//
//  Created by Anders Pettersson on 2023-07-27.
//

import SwiftUI
import Firebase

struct MainView: View {
    var body: some View {
        Text(String(Auth.auth().currentUser!.uid))
        
        Button(action: { SignOut() }) {
            Text("Sign out")
        }
    }
    
    func SignOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
