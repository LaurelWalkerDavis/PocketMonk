//
//  ConsolationViewModel.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/13/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class ConsolationViewModel : ObservableObject {
    
    @Published var consolations = [ConsolationModel]()
    @Published var docCount: Int = 0
    @Published var dateNum : String = ""
    let db = Firestore.firestore()
    
    
    init() {
        setDateNum()
        db.collection("consolations").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot
            else {
                print("Error fetching consolations: \(error!)")
                return
            }
            // Update the document count based on the number of documents in the collection
            self.docCount = snapshot.documents.count
        }
    }
    
    
    func fetchData() {
        self.consolations.removeAll()
        db.collection("consolations")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting consolations: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            self.consolations.append(try document.data(as: ConsolationModel.self))
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        //        db.collection("consolations").addSnapshotListener { snapshot, error in
        //            guard let snapshot = snapshot
        //            else {
        //                print("Error fetching consolations: \(error!)")
        //                return
        //            }
        //            // Update the document count based on the number of documents in the collection
        //            self.docCount = snapshot.documents.count
    }
    
    
    func saveData(consolations: ConsolationModel) {  // see https://firebase.google.com/docs/firestore/query-data/get-data#swift for help
        
        if let id = consolations.id {
            // This is to edit consolations that already exist. It connects with what's in Firebase and updates it.
            if !consolations.dateNum.isEmpty || !consolations.consolationData.isEmpty {
                let docRef = db.collection("consolations").document(id)
                
                docRef.updateData([
                    "consolationData" : consolations.consolationData,
                    "dateNum": getDateNum()
                ]) { err in
                    if let err = err {
                        print("Error updating consolation: \(err)")
                    } else {
                        print("Successfully updated consolation")
                    }
                }
            }
        } else {
            // Add consolation - this is a new consolation and does not already have an id in Firebase
            if !consolations.dateNum.isEmpty || !consolations.consolationData.isEmpty {
                    var ref: DocumentReference? = nil
                    ref = db.collection("consolations").addDocument(data: [
                        "consolationData": consolations.consolationData,
                        "dateNum": consolations.dateNum
                    ]) { err in
                        if let err = err {
                            print("Error adding consolation: \(err)")
                        } else {
                            print("Consolation added with ID: \(ref!.documentID)")
                        }
                    }
                }
            }
        }
        
        
        func getCurrentDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            return dateFormatter.string(from: Date())
        }
        
        func setDateNum() {
            dateNum = String(docCount) + " - " + getCurrentDate()
        }
        
        func getDateNum() -> String {
            return dateNum
        }
    }

