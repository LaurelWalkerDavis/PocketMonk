//
//  ConsolationEntry.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/14/23.
//

import SwiftUI
import CoreData

struct ConsolationEntry: View {
    @ObservedObject var consol = ConsolationViewModel()
    @State var details = ConsolationModel(dateNum: "", consolationData: "", date: Date()) // for creating a new consolation
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                //List {
                ForEach($consol.consolations) { $cns in
                    Text(cns.dateNum)
                        .bold()
                    Text(cns.consolationData)
                        .padding(.leading, 30)
                }
            }
            .onAppear {
                consol.fetchData()
            }
            .refreshable { // makes list refresh when you pull it down
                consol.fetchData()
            }
        }
    }
}


struct ConsolationEntry_Previews: PreviewProvider {
    static var previews: some View {
        ConsolationEntry()
    }
}
