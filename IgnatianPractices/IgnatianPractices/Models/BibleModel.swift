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

struct VerseResults : Codable {
    let data : ChapterVerseModel
    let meta : MetaModel
}

struct ChapterVerseModel : Codable, Identifiable {
    let id : String
    let bibleId : String
    let number : String
    let bookId : String
    let reference : String
    let copyright : String
    let verseCount : Int
    let content : String
    let next : ChapterModel
    let previous : ChapterModel
    
}

struct MetaModel : Codable {
//    var id : UUID { // have to have this for it to be identifiable
//        return UUID()
//    }
    let fums : String
    let fumsId : String
    let fumsJsInclude : String
    let fumsJs : String
    let fumsNoScript : String
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
    //let bibleId : String
    let number : String
    let bookId : String
    //let position : Int
}

//struct VerseModel : Codable, Identifiable {
//    let id : String
//    let orgId : String
//    let bibleId : String
//    let bookId : String
//    let chapterId : String
//    let reference : String
//}
