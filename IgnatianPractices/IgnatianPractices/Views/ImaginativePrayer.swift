//
//  ImagingPrayer.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/14/23.
//

import SwiftUI

struct ImaginativePrayer: View {
    @State var details = NoteModel(type: "imaginPrayer", dateStr: "", noteData: "", date: Date()) // for creating a new lectioDivina note
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section {
                    Text("In the Ignatian Tradition, prayer is vivid and active. We use our imagination and let our hearts, minds, and bodies enter into the stories we find in the Scriptures.")
                        .padding(.vertical, 4)
                } header: {
                    Text("Exercise Description")
                        .font(.system(size: 18))

                }
                Section {
                    Text("1. Read the passage once, thinking about the people in the story. With whom do you identify?")
                    Text("2. Re-read the passage from the perspective of your chosen person. Use your imagination to engage your five senses. What do you see? Hear? Taste? Smell? Feel?")
                    Text("3. Ask God, \"What are You showing me through this scene?\"")
                    Text("4. Write down what you have noticed.")
                        .padding(.vertical, 4)
                } header: {
                    Text("Invitation")
                        .font(.system(size: 18))
                }
                Section {
                    VerseView(passage: "GOSPEL")
                }header: {
                    Text("Gospel")
                        .font(.system(size: 18))
                }
                Section {
                    NoteView(note: $details)
                }header: {
                    Text("Today, I Noticed...")
                        .font(.system(size: 18))
                }
            }.listStyle(SidebarListStyle())
            
        }
    }
    struct ImagingPrayer_Previews: PreviewProvider {
        static var previews: some View {
            ImaginativePrayer()
        }
    }
}
