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
                //chptVersevm.verseData!.content
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

//struct VerseView_Previews: PreviewProvider {
//    static var previews: some View {
//        VerseView()
//    }
//}
