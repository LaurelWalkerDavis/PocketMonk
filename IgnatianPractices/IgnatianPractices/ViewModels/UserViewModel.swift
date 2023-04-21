//
//  UserViewModel.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/21/23.
//

//import Foundation
//import FirebaseFirestore
//
//class UserViewModel: ObservableObject {
//    
//    @Published var users = [User]()
//    
//    private var db = Firestore.firestore()
//    
//    func fetchData() {
//        db.collection("users").addSnapshotListener { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//            
//            self.users = documents.map { (queryDocumentSnapshot) -> User in
//                let data = queryDocumentSnapshot.data()
//                //let name = data["name"] as? String ?? ""
//                let email = data["email"] as? String ?? ""
//                return User(email: email)
//            }
//        }
//    }
//}
