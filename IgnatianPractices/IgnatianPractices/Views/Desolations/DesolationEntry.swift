//
//  DesolationEntry.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/14/23.
//

import SwiftUI

struct DesolationEntry: View {

        @ObservedObject var desol = DesolationViewModel()
        @State var details = DesolationModel(dateNum: "", desolationData: "", date: Date()) // for creating a new consolation
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    //List {
                    ForEach($desol.desolations) { $cns in
                        Text(cns.dateNum)
                            .bold()
                        Text(cns.desolationData)
                            .padding(.leading, 30)
                    }
                }
                .onAppear {
                    desol.fetchData()
                }
                .refreshable { // makes list refresh when you pull it down
                    desol.fetchData()
                }
            }
        }
    }

struct DesolationEntry_Previews: PreviewProvider {
    static var previews: some View {
        DesolationEntry()
    }
}
