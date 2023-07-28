//
//  RegisterView.swift
//  MovieRater
//
//  Created by Anders Pettersson on 2023-07-27.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                
                Text("Welcome to MovieRater")
                    .font(.title)
                    .fontWeight(.bold)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                
                Button(action: {
                    Task {
                        try await viewModel.createUser(withEmail: email, password: password)
                    }
                }) {
                    Text("Register")
                }
                
                
                Spacer()
                
                NavigationLink {
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account? ")
                        Text("Login!").fontWeight(.bold)
                    }
                }
            }
        }
        
        .padding()
    }
    
    func Register() {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("Registered")
            }
        }
    }
}



struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
