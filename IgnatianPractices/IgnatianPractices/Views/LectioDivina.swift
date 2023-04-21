//
//  LectioDivina.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/14/23.
//

import SwiftUI

struct LectioDivina: View {
    @State var details = NoteModel(type: "lectioDivina", dateStr: "", noteData: "", date: Date()) // for creating a new lectioDivina note
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section {
                    Text("Lectio Divina is Latin and means \"Divine Reading\". It refers to a method of reading the Scriptures in a meditative way that softens the heart.")
                        .padding(.vertical, 4)
                } header: {
                    Text("Exercise Description")
                        .font(.system(size: 18))

                }
                Section {
                    Text("1. Read the passage once, noting any key words or phrases that stick out.")
                    Text("2. Re-read the passage, reflecting on the key word or phrase.")
                    Text("3. Re-read the paragraph that contains the key word or phrase. Ask God, \"What are You saying to me in this word?\"")
                    Text("4. Write down the word or phrase. Rest with it and be still.")
                        .padding(.vertical, 4)
                } header: {
                    Text("Invitation")
                        .font(.system(size: 18))
                }
                Section {
                    VerseView(passage: "PSALM")
                }header: {
                    Text("Psalm")
                        .font(.system(size: 18))
                }
                Section {
                    NoteView(note: $details)
                }header: {
                    Text("My Word Today")
                        .font(.system(size: 18))
                }
            }.listStyle(SidebarListStyle())
            
        }
    }
    
    struct LectioDivina_Previews: PreviewProvider {
        static var previews: some View {
            LectioDivina()
        }
    }
}
