//
//  DesolationDetail.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/14/23.
//

import SwiftUI

struct DesolationDetail: View {
    
    @Binding var desolation : DesolationModel // binding allows users to interact with the variable. need to add $.
    //@Binding var dateNum : String
    @ObservedObject var consol = DesolationViewModel()
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TextField(consol.getDateString(), text: $desolation.dateNum)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                TextEditor(text: $desolation.desolationData) // TextEditor is better for multi-line fields
                    .font(.system(size: 20))
                    .frame(width: 300, height: 400)
                    .cornerRadius(8)
                HStack {
                    Spacer()
                    Button(action: {
                        consol.saveData(desolations: desolation)
                        desolation.dateNum = ""  //clear previous content display
                        desolation.desolationData = "" //clear previous content display
                    }, label: {
                        Text("Save")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.brown)
                    })
                    Spacer()
                }
            }
        }.padding()

    }
    
    
    struct DesolationDetail_Previews: PreviewProvider {
        @Binding var desolation : DesolationModel // binding allows users to interact with the variable. need to add $.
        static var previews: some View {
            DesolationDetail(desolation: .constant(DesolationModel(dateNum: "Today's Date", desolationData: "This is how I felt desolation.", date: Date())))
        }
    }
}
