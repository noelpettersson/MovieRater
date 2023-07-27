//
//  AuthManager.swift
//  MovieRater
//
//  Created by Anders Pettersson on 2023-07-27.
//

import FirebaseAuth

class AuthManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?

    init() {
        // Check the initial authentication state when the app loads
        checkUserAuthentication()
    }

    func checkUserAuthentication() {
        // Add an observer to monitor the user authentication state
        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            self?.isAuthenticated = user != nil
            self?.currentUser = user
        }
    }

    func registerUser(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }

    func loginUser(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }

    func logoutUser() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
