//
//  DesolationHistory.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/14/23.
//

//import SwiftUI
//
//struct DesolationHistory: View {
//        @ObservedObject var desol = DesolationViewModel()
//        @State var details = DesolationModel(dateNum: "", desolationData: "", date: Date())
//        
//        var body: some View {
//            NavigationView {
//                List {
//                    ForEach($desol.desolations) { $des in
//                        NavigationLink {
//                            DesolationDetail(desolation: $des)
//                        } label: {
//                            Text(des.dateNum)
//                        }
//                    }
//                }.navigationBarTitle("Desolations")
//
//            }            
//                .onAppear {
//                    desol.fetchData()
//                }
//                .refreshable { // makes list refresh when you pull it down
//                    desol.fetchData()
//                }
//            
//        }
//    }
//
//
//
//struct DesolationHistory_Previews: PreviewProvider {
//    static var previews: some View {
//        DesolationHistory()
//    }
//}
