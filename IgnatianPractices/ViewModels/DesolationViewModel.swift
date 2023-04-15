//
//  DesolationViewModel.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/14/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class DesolationViewModel : ObservableObject {
    
    @Published var desolations = [DesolationModel]()
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
        self.desolations.removeAll()
        //var query = db.collection("desolations")
        let query = Firestore.firestore().collection("desolations")
        if let date = date {
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
            let startDate = calendar.date(from: dateComponents)!
            let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
            
            query
                .whereField("date", isGreaterThanOrEqualTo: startDate)
                .whereField("date", isLessThan: endDate).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting desolations: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            self.desolations.append(try document.data(as: DesolationModel.self))
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
                    print("Error getting desolations: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            self.desolations.append(try document.data(as: DesolationModel.self))
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
    
    func saveData(desolations: DesolationModel) {  // see https://firebase.google.com/docs/firestore/query-data/get-data#swift for help
        
        if let id = desolations.id {
            // This is to edit desolations that already exist. It connects with what's in Firebase and updates it.
            if !desolations.dateNum.isEmpty || !desolations.desolationData.isEmpty {
                let docRef = db.collection("desolations").document(id)
                
                docRef.updateData([
                    "desolationData" : desolations.desolationData,
                    "date" : desolations.date,
                    "dateNum" : dateNum
                ]) { err in
                    if let err = err {
                        print("Error updating Desolation: \(err)")
                    } else {
                        print("Successfully updated Desolation")
                    }
                }
            }
        } else {
            // Add Desolation - this is a new Desolation and does not already have an id in Firebase
            updateDocCount()
            setDateNum()
            if !desolations.dateNum.isEmpty || !desolations.desolationData.isEmpty {
                var ref: DocumentReference? = nil
                ref = db.collection("desolations").addDocument(data: [
                    "desolationData": desolations.desolationData,
                    "date" : desolations.date,
                    "dateNum": dateNum
                ]) { err in
                    if let err = err {
                        print("Error adding Desolation: \(err)")
                    } else {
                        print("Desolation added with ID: \(ref!.documentID)")
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
        db.collection("desolations").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot
            else {
                print("Error fetching desolations: \(error!)")
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

