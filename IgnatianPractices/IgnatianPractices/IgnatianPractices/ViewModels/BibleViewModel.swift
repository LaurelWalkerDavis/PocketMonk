//
//  ViewModel.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/2/23.
//

import Foundation

class BibleViewModel : ObservableObject {
    
    @Published private(set) var bibleData = [BookModel]()
    @Published var hasError = false
    @Published var error : BibleModelError?
    private let url = "https://api.scripture.api.bible/v1/bibles/06125adad2d5898a-01/books"
    
    
    @Published private(set) var listOfGospels = [BookModel]() //variable is public, but the setter is private // @Pub tells program that this is the variable that will be changing and published
    @Published private(set) var listOfPsalms = [ChapterModel]() //variable is public, but the setter is private // @Pub tells program that this is the variable that will be changing and published
    
    
    @MainActor // run on main thread
    func fetchData() async {
        if let url = URL(string: url) {
            do {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("94349ae7ff143041ad9e8dc62b39fa80", forHTTPHeaderField: "api-key")
                let (data, _) = try await URLSession.shared.data(for: request)
                guard let results = try JSONDecoder().decode(BibleResults?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = BibleModelError.decodeError
                    return
                }
                self.bibleData = results.data
            } catch {
                self.hasError.toggle()
                self.error = BibleModelError.customError(error: error)
            }
        }
    }
}
//    func fetchGospels() {
//        ForEach(self.bibleData.) {
//            bk in BookModel(id: <#T##String#>, bibleId: <#T##String#>, abbreviation: <#T##String#>, name: <#T##String#>, nameLong: <#T##String#>, chapters: <#T##[ChapterModel]#>)
//        }
//
//        self.listOfGospels = [
//            BookModel(id: "MAT", bibleId: "06125adad2d5898a-01", abbreviation: "Mt.", name: "Matthew", nameLong: "The Gospel According to Matthew", chapters: <#[ChapterModel]#>),
//            BookModel(id: "MRK"),
//            BookModel(id: "LUK"),
//            BookModel(id: "JHN"),
//            ]
//        }
//    }

extension BibleViewModel {
    enum BibleModelError : LocalizedError {
        case decodeError
        case customError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .decodeError:
                return "Error while decoding"
            case .customError(let error):
                return error.localizedDescription
            }
        }
    }
}
