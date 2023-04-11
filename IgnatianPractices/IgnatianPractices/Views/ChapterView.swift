//
//  ChapterView.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/8/23.
//

import SwiftUI

struct ChapterView: View {
    
    var book : BookModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(book.chapters) { chpt in
                            NavigationLink(chpt.number) {
                                ChapterView(book: book)
                            }
                        }
                    }
                }
            }
        }

