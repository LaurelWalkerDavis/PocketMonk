//
//  BibleView.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/2/23.
//

import SwiftUI

struct ChapterView: View {
    @ObservedObject var biblevm = BibleViewModel()
    
    
    var body: some View {
        ScrollView {
            ForEach(biblevm.bibleData) {
                book in Text(book.name)
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


struct ChapterView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterView()
    }
}
