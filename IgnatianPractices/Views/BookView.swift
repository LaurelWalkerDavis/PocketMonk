//
//  BookView.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/7/23.
//

import SwiftUI

struct BookView: View {
    @ObservedObject var biblevm = BibleViewModel()
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(biblevm.bookData) { book in
                    NavigationLink {
                        ChapterView(book: book)
                    } label: {
                        Text(book.name)
                    }
                }
                
            }
            ScrollView {
                ForEach(biblevm.bookData) {
                    chapter in
                }
                .task {
                    await biblevm.fetchData()
                }
                .listStyle(.grouped)
                .navigationTitle("Passage")
                .alert(isPresented: $biblevm.hasError, error: biblevm.error) {
                    Text("")
                } // .alert addresses error handling
            }
        }
    }
}


struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}
