//
//  SignUpView.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/20/23.
//

import SwiftUI
import FirebaseAuth
import Combine

private enum FocusableField: Hashable {
  case email
  case password
  case confirmPassword
}

struct SignUpView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss

    @FocusState private var focus: FocusableField?

    private func signUpWithEmailPassword() {
      Task {
        if await viewModel.signUpWithEmailPassword() == true {
          dismiss()
        }
      }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo2")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 500)
                    .background(Color.white.opacity(0.2)) // add a color overlay if needed
                Text("Create an Account").font(.largeTitle).bold()
                HStack {
                    Image(systemName: "at.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                    TextField("Email Address", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .focused($focus, equals: .email)
                        .submitLabel(.next)
                        .onSubmit {
                            self.focus = .password
                        }
                }.padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                HStack {
                    Image(systemName: "lock.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                    SecureField("Password", text: $viewModel.password)
                        .focused($focus, equals: .password)
                        .submitLabel(.next)
                        .onSubmit {
                            self.focus = .confirmPassword
                        }
                }.padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                
                HStack {
                  Image(systemName: "checkmark.shield.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                  SecureField("Confirm password", text: $viewModel.confirmPassword)
                    .focused($focus, equals: .confirmPassword)
                    .submitLabel(.go)
                    .onSubmit {
                      signUpWithEmailPassword()
                    }
                }.padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
              
                if !viewModel.errorMessage.isEmpty {
                  VStack {
                    Text(viewModel.errorMessage)
                      .foregroundColor(Color(UIColor.systemRed))
                  }
                }
                
                Button(action: signUpWithEmailPassword) {
                    if viewModel.authenticationState != .authenticating {
                        Text("Sign up")
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                    }
                    else {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(!viewModel.isValid)
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                
                HStack {
                  Text("Already have an account?")
                  Button(action: { viewModel.switchFlow() }) {
                    Text("Log in")
                      .fontWeight(.semibold)
                      .foregroundColor(.blue)
                  }
                }
                .padding([.top, .bottom], 50)
                
                Spacer()
                Spacer()
            }

        }.padding()
    }
}

struct SignupView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SignUpView()
      SignUpView()
        .preferredColorScheme(.dark)
    }
    .environmentObject(AuthenticationViewModel())
  }
}
