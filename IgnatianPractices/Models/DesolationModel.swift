//
//  DesolationModel.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/14/23.
//

import Foundation
import FirebaseFirestoreSwift //import this and add @DocumentID to allow Firebase to generate IDs

struct DesolationModel : Codable, Identifiable {
    @DocumentID var id: String?
    var dateNum: String
    var desolationData: String
    var date: Date
}
