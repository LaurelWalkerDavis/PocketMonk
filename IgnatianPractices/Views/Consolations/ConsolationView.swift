//
//  ConsolationView.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/13/23.
//

import SwiftUI

struct ConsolationView: View {
    
    @ObservedObject var consol = ConsolationViewModel()
    @State var details = ConsolationModel(dateNum: "", consolationData: "", date: Date()) // for creating a new consolation
    @State var email = ""
    @State var today : Date = Date()
    // @State
    // @ObservedObject - used to observe changes to an existing instance of an object. owned an managed by an external entity. data is not stored within the view.
    // @StateObject - data is stored within the view.
    
    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("A spiritual consolation “is a profound experience of interior joy, consisting in seeing God’s presence in everything. It strengthens faith and hope and also the ability to do good,” - Pope Francis")
                }header: {
                    Text("Exercise Instructions")
                }
                Section {
                    Text("When did I feel joy today? When did I feel close to God and others? When did I notice something beautiful?")
                }header: {
                    Text("Guiding Questions")
                }
                
                Section {
                    NavigationLink {
                        ConsolationDetail(consolation: $details)
                    } label: {
                        Text("Add New Consolation")
                            .foregroundColor(Color.green)
                            .font(.system(size: 20))
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
                } header: {
                    Text("Today's Consolations")
                }
            }.navigationBarTitle(Text("Daily Consolations"))
                //.navigationBarTitleDisplayMode(.inline)
                .ignoresSafeArea(edges: .bottom)
            
            .onAppear {
                consol.fetchData(date: today)
            }
            .refreshable { // makes list refresh when you pull it down
                consol.fetchData(date: today)
            }
        }
    }
    
    
    struct ConsolationView_Previews: PreviewProvider {
        static var previews: some View {
            ConsolationView()
        }
    }
    
}
