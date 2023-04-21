//
//  VerseView.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/8/23.
//

import SwiftUI

struct VerseView: View {
    
    @ObservedObject var chptVersevm = VerseViewModel()
    @State var passage = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Text(chptVersevm.verseData?.content ?? "").task {
                    await chptVersevm.fetchData(passage)
                }
                .padding()
                .navigationTitle(chptVersevm.title)
                .alert(isPresented: $chptVersevm.hasError, error: chptVersevm.error) {
                    Text("")
                }
            }
        }
    }
}


