//
//  ContemplationModel.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/17/23.
//

import Foundation
import FirebaseFirestoreSwift //import this and add @DocumentID to allow Firebase to generate IDs

struct ContemplationModel {
    let fileName: String
    let description: String
    let credit: String
}
