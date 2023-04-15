//
//  DesolationsView.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/14/23.
//

import SwiftUI

struct DesolationsView: View {
    
    @ObservedObject var desol = DesolationViewModel()
    @State var details = DesolationModel(dateNum: "", desolationData: "", date: Date()) // for creating a new desolation
    @State var email = ""
    @State var today : Date = Date()
    // @State
    // @ObservedObject - used to observe changes to an existing instance of an object. owned an managed by an external entity. data is not stored within the view.
    // @StateObject - data is stored within the view.
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Daily Desolations")
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                Section {
                    Text("A spiritual desolation is an experience of darkness of soul, disturbance in it, movement to things low and earthly, the unquiet of different agitations and temptations, moving to want of confidence, without hope, without love, when one finds oneself all lazy, tepid, sad and as if separated from his Creator and Lord.” - Pope Francis")
                }header: {
                    Text("Exercise Instructions")
                }
                Section {
                    Text("When did I feel hopelessness today? When did I feel distant from God and others? When did I stop seeing beauty?")
                }header: {
                    Text("Guiding Questions")
                }
                
//                Section {
//                    NavigationLink {
//                        DesolationDetail(desolation: $details)
//                    } label: {
//                        Text("Add New Desolation")
//                            .foregroundColor(Color.green)
//                            .font(.system(size: 20))
//                    }
//                }
                Section {
                    DesolationDetail(desolation: $details)
                }header: {
                    Text("My Desolations")
                }
                Section {
                    ForEach($desol.desolations) { $des in
                        NavigationLink {
                            DesolationDetail(desolation: $des)
                        } label: {
                            Text(des.dateNum)
                        }
                    }
                } header: {
                    Text("Today's Desolations")
                }
            }.listStyle(SidebarListStyle())
            .onAppear {
                desol.fetchData(date: today)
            }
            .refreshable { // makes list refresh when you pull it down
                desol.fetchData(date: today)
            }
        }
    }
    
    struct DesolationsView_Previews: PreviewProvider {
        static var previews: some View {
            DesolationsView()
        }
    }
}
