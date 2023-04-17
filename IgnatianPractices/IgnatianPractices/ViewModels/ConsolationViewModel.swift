//
//  ConsolationViewModel.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/13/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import CoreData

class ConsolationViewModel : ObservableObject {
    
    @Published var consolations = [ConsolationModel]()
    @Published var docCount: Int = 1
    @Published var dateNum : String = ""
    @Published var date = Date()
    let db = Firestore.firestore()
    
    
    init() {
        updateDocCount()
        setCurrentDate()
        setDateNum()
    }
    
    
    func fetchData(date: Date? = nil) {
        self.consolations.removeAll()
        let query = Firestore.firestore().collection("consolations")
                
        if let date = date {
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
            let startDate = calendar.date(from: dateComponents)!
            let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!

            query
                .whereField("date", isGreaterThanOrEqualTo: startDate)
                .whereField("date", isLessThan: endDate).getDocuments() { (querySnapshot, err) in
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
        }
        else {
             query.getDocuments() { (querySnapshot, err) in
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
        }
    }
    
    
    func saveData(consolations: ConsolationModel) {  // see https://firebase.google.com/docs/firestore/query-data/get-data#swift for help
        
        if let id = consolations.id {
            // This is to edit consolations that already exist. It connects with what's in Firebase and updates it.
            if !consolations.dateNum.isEmpty || !consolations.consolationData.isEmpty {
                let docRef = db.collection("consolations").document(id)
                
                docRef.updateData([
                    "consolationData" : consolations.consolationData,
                    "date" : consolations.date,
                    "dateNum" : dateNum
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
            updateDocCount()
            setDateNum()
            if !consolations.dateNum.isEmpty || !consolations.consolationData.isEmpty {
                var ref: DocumentReference? = nil
                ref = db.collection("consolations").addDocument(data: [
                    "consolationData": consolations.consolationData,
                    "date" : consolations.date,
                    "dateNum": dateNum
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
    
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let dt = dateFormatter.string(from: Date())
        return dt
    }
    
    func setCurrentDate() {
        self.date = Date()
    }
    
    func updateDocCount() {
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
    
    func setDateNum() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let dt = dateFormatter.string(from: Date())
        dateNum = String(docCount) + " - " + "\(dt)"
    }
}

