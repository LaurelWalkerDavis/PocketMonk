//
//  NoteViewModel.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/17/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class NoteViewModel : ObservableObject {
@Published var notes = [NoteModel]()
//@Published var docCount: Int = 1
//@Published var dateNum : String = ""
@Published var dateStr : String = ""

@Published var date = Date()
let db = Firestore.firestore()


init() {
    //updateDocCount()
    setCurrentDate()
    setDateStr()
}


func fetchData(date: Date? = nil) {
    self.notes.removeAll()
    //var query = db.collection("notes")
    let query = Firestore.firestore().collection("notes")
    if let date = date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let startDate = calendar.date(from: dateComponents)!
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        
        query
            .whereField("date", isGreaterThanOrEqualTo: startDate)
            .whereField("date", isLessThan: endDate).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting notes: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        self.notes.append(try document.data(as: NoteModel.self))
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
                print("Error getting notes: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        self.notes.append(try document.data(as: NoteModel.self))
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}


func saveData(notes: NoteModel) {  // see https://firebase.google.com/docs/firestore/query-data/get-data#swift for help
    
    if let id = notes.id {
        // This is to edit notes that already exist. It connects with what's in Firebase and updates it.
        if !notes.dateStr.isEmpty || !notes.noteData.isEmpty || !notes.type.isEmpty {
            let docRef = db.collection("notes").document(id)
            
            docRef.updateData([
                "noteData" : notes.noteData,
                "date" : notes.date,
                "dateStr" : dateStr,
                "type" : notes.type
            ]) { err in
                if let err = err {
                    print("Error updating Note: \(err)")
                } else {
                    print("Successfully updated Note")
                }
            }
        }
    } else {
        // Add Note - this is a new Note and does not already have an id in Firebase
        //updateDocCount()
        setDateStr()
        if !notes.dateStr.isEmpty || !notes.noteData.isEmpty || !notes.type.isEmpty {
            var ref: DocumentReference? = nil
            ref = db.collection("notes").addDocument(data: [
                "noteData": notes.noteData,
                "date" : notes.date,
                "dateStr": dateStr,
                "type" : notes.type
            ]) { err in
                if let err = err {
                    print("Error adding Note: \(err)")
                } else {
                    print("Note added with ID: \(ref!.documentID)")
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

func setDateStr() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    let dt = dateFormatter.string(from: Date())
    dateStr = dt
}

func setCurrentDate() {
    self.date = Date()
}

//func updateDocCount() {
//    db.collection("notes").addSnapshotListener { snapshot, error in
//        guard let snapshot = snapshot
//        else {
//            print("Error fetching notes: \(error!)")
//            return
//        }
//        // Update the document count based on the number of documents in the collection
//        self.docCount = snapshot.documents.count
//    }
//}

//func setDateStr() {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateStyle = .long
//    let dt = dateFormatter.string(from: Date())
//    dateNum = String(docCount) + " - " + "\(dt)"
//}
}
