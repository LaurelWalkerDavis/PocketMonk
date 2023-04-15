//
//  LifeReviewView.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/14/23.
//

import SwiftUI

struct LifeReviewView: View {
    @ObservedObject var consol = ConsolationViewModel()
    @State var details = ConsolationModel(dateNum: "", consolationData: "", date: Date()) // for creating a new consolation
    
    @State var email = ""
    // @State
    // @ObservedObject - used to observe changes to an existing instance of an object. owned an managed by an external entity. data is not stored within the view.
    // @StateObject - data is stored within the view.
    
    var body: some View {
        NavigationView {
            List {  
                Section {
                    NavigationLink {
                        VerseView(passage: "PSALM")
                    } label: {
                        Text("Lectio Divina")
                            .font(.system(size: 25))
                    }
                    NavigationLink {
                        VerseView(passage: "GOSPEL")
                    } label: {
                        Text("Imaging Prayer")
                            .font(.system(size: 25))
                    }
                    NavigationLink {
                        ConsolationHistory()
                    } label: {
                        Text("Consolations")
                            .font(.system(size: 25))
                    }
                    NavigationLink {
                        DesolationHistory()
                    } label: {
                        Text("Desolations")
                            .font(.system(size: 25))
                    }
                } header: {
                    Text("Daily Insights")
                        .font(.headline)
                }
            }.background(Color.black)
                .navigationBarTitle("Life Review")
                .environment(\.defaultMinListRowHeight, 80)
        }
        
    }
    
    
    struct LifeReviewView_Previews: PreviewProvider {
        static var previews: some View {
            LifeReviewView()
        }
    }
}
