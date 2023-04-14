//
//  ConsolationView.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/13/23.
//

import SwiftUI

struct ConsolationView: View {
    
    @ObservedObject var consol = ConsolationViewModel()
    @State var details = ConsolationModel(dateNum: "", consolationData: "") // for creating a new consolation
    
    @State var email = ""
    // @State
    // @ObservedObject - used to observe changes to an existing instance of an object. owned an managed by an external entity. data is not stored within the view.
    // @StateObject - data is stored within the view.
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        ConsolationDetail(consolation: $details)
                    } label: {
                        Text("New consolation")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 15))
                    }
                }
                Section {
                    ForEach($consol.consolations) { $cns in
                        NavigationLink {
                            ConsolationDetail(consolation: $cns)
                        } label: {
                            Text(cns.dateNum)
                        }
                    }
                }                
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

struct ConsolationView_Previews: PreviewProvider {
    static var previews: some View {
        ConsolationView()
    }
}
