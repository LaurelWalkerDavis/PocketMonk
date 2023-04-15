//
//  ConsolationDetail.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/13/23.
//

import SwiftUI

struct ConsolationDetail: View {
    
    @Binding var consolation : ConsolationModel // binding allows users to interact with the variable. need to add $.
    //@Binding var dateNum : String
    @ObservedObject var consol = ConsolationViewModel()
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TextField(consol.getDateString(), text: $consolation.dateNum)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                TextEditor(text: $consolation.consolationData) // TextEditor is better for multi-line fields
                    .font(.system(size: 20))
                    .frame(width: 300, height: 400)
                    .cornerRadius(8)
                HStack {
                    Spacer()
                    Button(action: {
                        consol.saveData(consolations: consolation)
                        consolation.dateNum = ""  //clear previous content display
                        consolation.consolationData = "" //clear previous content display
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
        
        //        .toolbar {
        //            ToolbarItem(placement: .navigationBarTrailing) {
        //                Button {
        //                    consol.saveData(consolations: consolation)
        //                    consolation.dateNum = ""  //clear previous content display
        //                    consolation.consolationData = "" //clear previous content display
        //                } label: {
        //                    Text("Save")
        //                }
        //
        //            }
        //        }
    }
    
    
    struct ConsolationDetail_Previews: PreviewProvider {
        @Binding var consolation : ConsolationModel // binding allows users to interact with the variable. need to add $.
        static var previews: some View {
            ConsolationDetail(consolation: .constant(ConsolationModel(dateNum: "Today's Date", consolationData: "This is how I felt consoled.", date: Date())))
        }
    }
}
