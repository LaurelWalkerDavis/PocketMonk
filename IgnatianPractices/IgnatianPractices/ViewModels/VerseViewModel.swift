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
    @Published private(set) var title = ""
    //private let url = getChapterAPIURL()
    
    
    @MainActor // run on main thread
    func fetchData(_ passage: String) async {
        if passage == "PSALM" {
            self.title = "Lectio Divina"
            if let url = getPsalmAPIURL() {
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
        } else {
            self.title = "Imaginative Prayer"
            if let url = getGospelAPIURL() {
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
        }
    }


func getPsalmAPIURL() -> URL? {
    let baseURLString = "https://api.scripture.api.bible/v1/bibles/06125adad2d5898a-01/chapters/PSA." + randomPsalm()
    
    
    let queryParameters = [
        "content-type": "text",
        "include-notes": "false",
        "include-titles": "true",
        "include-chapter-numbers": "false",
        "include-verse-numbers": "true",
        "include-verse-spans": "false"
    ]
    
    
    var urlComponents = URLComponents(string: baseURLString)
    urlComponents?.queryItems = queryParameters.map { key, value in
        URLQueryItem(name: key, value: value)
    }
    
    return urlComponents?.url
}

func randomPsalm() -> String {
    return String(Int.random(in: 1...150))
}


func getGospelAPIURL() -> URL? {
    let baseURLString = "https://api.scripture.api.bible/v1/bibles/06125adad2d5898a-01/chapters/" + randomGospel()
    
    
    let queryParameters = [
        "content-type": "text",
        "include-notes": "false",
        "include-titles": "true",
        "include-chapter-numbers": "false",
        "include-verse-numbers": "true",
        "include-verse-spans": "false"
    ]
    
    
    var urlComponents = URLComponents(string: baseURLString)
    urlComponents?.queryItems = queryParameters.map { key, value in
        URLQueryItem(name: key, value: value)
    }
    
    return urlComponents?.url
}

func randomGospel() -> String {
    let gospels = ["MAT", "MRK", "LUK", "JHN"]
    let selectedGospel = gospels.randomElement()
    
    switch selectedGospel {
    case "MAT":
        return String("MAT." + String(Int.random(in: 1...28)))
    case "MRK":
        return String("MRK." + String(Int.random(in: 1...16)))
    case "LUK":
        return String("LUK." + String(Int.random(in: 1...24)))
    case "JHN":
        return String("JHN." + String(Int.random(in: 1...21)))
    default:
        return String("MAT." + String(Int.random(in: 1...28)))
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
