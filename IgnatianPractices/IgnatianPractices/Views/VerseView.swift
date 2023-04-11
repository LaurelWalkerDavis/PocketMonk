//
//  VerseView.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/8/23.
//

import SwiftUI

struct VerseView: View {
    
    @ObservedObject var chptVersevm = VerseViewModel()
    
    var body: some View {
        VStack {
            //chptVersevm.verseData!.content
            Text(chptVersevm.verseData?.content ?? "test").task {
                await chptVersevm.fetchData()
            }
            .listStyle(.grouped)
            .navigationTitle("Passage")
            .alert(isPresented: $chptVersevm.hasError, error: chptVersevm.error) {
                Text("")
            }
        }
    }
}

//struct VerseView_Previews: PreviewProvider {
//    static var previews: some View {
//        VerseView()
//    }
//}
