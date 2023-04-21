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
                        .font(.system(size: 18))
                }
                Section {
                    Text("When did I feel hopelessness today? When did I feel distant from God and others? When did I stop seeing beauty?")
                }header: {
                    Text("Guiding Questions")
                        .font(.system(size: 18))
                }                

                Section {
                    DesolationDetail(desolation: $details)
                }header: {
                    Text("My Desolations")
                        .font(.system(size: 18))
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
                        .font(.system(size: 18))
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
