//
//  LoginViewModel.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/20/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

enum AuthenticationFlow {
    case login
    case signUp
}

@MainActor
class AuthenticationViewModel : ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var isValid  = false
    @Published var flow: AuthenticationFlow = .login
    @Published var authenticationState: AuthenticationState = .unauthenticated
    
    @Published var errorMessage = ""
    @Published var user: User?
    @Published var displayName = ""
    
    
    init() {
      registerAuthStateHandler()

      $flow
        .combineLatest($email, $password, $confirmPassword)
        .map { flow, email, password, confirmPassword in
          flow == .login
            ? !(email.isEmpty || password.isEmpty)
            : !(email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
        }
        .assign(to: &$isValid)
    }

    private var authStateHandler: AuthStateDidChangeListenerHandle?

    func registerAuthStateHandler() {
      if authStateHandler == nil {
        authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
          self.user = user
          self.authenticationState = user == nil ? .unauthenticated : .authenticated
          self.displayName = user?.email ?? ""
        }
      }
    }

    func switchFlow() {
      flow = flow == .login ? .signUp : .login
      errorMessage = ""
    }

    private func wait() async {
      do {
        print("Wait")
        try await Task.sleep(nanoseconds: 1_000_000_000)
        print("Done")
      }
      catch {
        print(error.localizedDescription)
      }
    }

    func reset() {
      flow = .login
      email = ""
      password = ""
      confirmPassword = ""
    }
    
    func getUser() -> User? {
        return user
    }
  }
    


// MARK: - Email and Password Authentication
extension AuthenticationViewModel {
  func signInWithEmailPassword() async -> Bool {
    authenticationState = .authenticating
    do {
      try await Auth.auth().signIn(withEmail: self.email, password: self.password)
      return true
    }
    catch  {
      print(error)
      errorMessage = error.localizedDescription
      authenticationState = .unauthenticated
      return false
    }
  }

  func signUpWithEmailPassword() async -> Bool {
    authenticationState = .authenticating
    do  {
      try await Auth.auth().createUser(withEmail: email, password: password)
      return true
    }
    catch {
      print(error)
      errorMessage = error.localizedDescription
      authenticationState = .unauthenticated
      return false
    }
  }

  func signOut() {
    do {
      try Auth.auth().signOut()
    }
    catch {
      print(error)
      errorMessage = error.localizedDescription
    }
  }

  func deleteAccount() async -> Bool {
    do {
      try await user?.delete()
      return true
    }
    catch {
      errorMessage = error.localizedDescription
      return false
    }
  }
}
