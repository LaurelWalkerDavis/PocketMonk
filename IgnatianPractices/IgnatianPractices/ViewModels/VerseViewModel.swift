//
//  VerseModel.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/9/23.
//

import Foundation

class VerseViewModel : ObservableObject {
    @Published private(set) var verseData : ChapterVerseModel?
    //@Published private(set) var verseData = ChapterVerseModel()
    @Published var hasError = false
    @Published var error : VerseModelError?
    //private let url = getChapterAPIURL()
    
    
    @MainActor // run on main thread
    func fetchData() async {
        if let url = getChapterAPIURL() {
            do {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("94349ae7ff143041ad9e8dc62b39fa80", forHTTPHeaderField: "api-key")
                let (data, _) = try await URLSession.shared.data(for: request)
                guard let results = try JSONDecoder().decode(VerseResults?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = VerseModelError.decodeError
                    return
                }
                self.verseData = results.data
            } catch {
                self.hasError.toggle()
                self.error = VerseModelError.customError(error: error)
            }
        }
    }
    
    //https://api.scripture.api.bible/v1/bibles/06125adad2d5898a-01/chapters/PSA.1?content-type=html&include-notes=false&include-titles=true&include-chapter-numbers=false&include-verse-numbers=true&include-verse-spans=false
    
    func getChapterAPIURL() -> URL? {
        let baseURLString = "https://api.scripture.api.bible/v1/bibles/06125adad2d5898a-01/chapters/PSA." + randomPsalm()
        
        //let endpoint = "?content-type=html&include-notes=false&include-titles=true&include-chapter-numbers=false&include-verse-numbers=true&include-verse-spans=false"
        let queryParameters = [
            "content-type": "text",
            "include-notes": "false",
            "include-titles": "true",
            "include-chapter-numbers": "false",
            "include-verse-numbers": "true",
            "include-verse-spans": "false"
        ]
        
//        let queryParameters = [
//            "bookId": "PSA",
//            "chapterId": randomPsalm()
//        ]
        
        var urlComponents = URLComponents(string: baseURLString)
        urlComponents?.queryItems = queryParameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        return urlComponents?.url
    }
    
    
    func randomPsalm() -> String {
        return String(Int.random(in: 1...150))
    }
}

extension VerseViewModel {
    enum VerseModelError : LocalizedError {
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
