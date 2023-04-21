//
//  NoteEntry.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/17/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct NoteEntry: View {
    @ObservedObject var note = NoteViewModel()
    @State var details = NoteModel(type: "", dateStr: "", noteData: "", date: Date()) // for creating a new consolation
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    //List {
                    ForEach($note.notes) { $nt in
                        if nt.type == details.type {
                            Text(nt.dateStr)
                                .bold()
                            Text(nt.noteData)
                                .padding(.leading, 30)
                        }
                    }
                }
                .onAppear {
                    note.fetchData()
                }
                .refreshable { // makes list refresh when you pull it down
                    note.fetchData()
                }
            }
        }
    }

struct NoteEntry_Previews: PreviewProvider {
    static var previews: some View {
        NoteEntry()
    }
}
