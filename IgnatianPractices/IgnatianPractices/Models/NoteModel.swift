//
//  NoteModel.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/17/23.
//

import Foundation
import FirebaseFirestoreSwift //import this and add @DocumentID to allow Firebase to generate IDs

struct NoteModel : Codable, Identifiable {
    @DocumentID var id: String?
    var type: String
    var dateStr: String
    var noteData: String
    var date: Date
}

