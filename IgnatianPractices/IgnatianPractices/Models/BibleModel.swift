//
//  BibleModel.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/2/23.
//

import Foundation

struct BibleResults : Codable {
    let data : [BookModel]
}

struct BookModel : Codable, Identifiable {
    let id : String
    let bibleId : String
    let abbreviation : String
    let name : String
    let nameLong : String
    let chapters : [ChapterModel]
}

struct ChapterModel : Codable, Identifiable {
    let id : String
    let bibleId : String
    let number : String
    let bookId : String
    //let reference : String
    //let content : String
    //let verseCount : Int
    //let next : [NxPvModel]
    //let previous : [NxPvModel]
    //let copyright : String
}
