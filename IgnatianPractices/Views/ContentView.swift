//
//  ContentView.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/2/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var verseVM = VerseViewModel()
    
    var body: some View {
        ZStack {
            Color("Background").edgesIgnoringSafeArea(.all)
            NavigationView {
                List {
                    //BookView()
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
                            Examen()
                        } label: {
                            Text("Examen")
                                .font(.system(size: 25))
                        }
                        NavigationLink {
                            LifeReviewView()
                        } label: {
                            Text("Life Review")
                                .font(.system(size: 25))
                        }
                    } header: {
                        Text("Daily exercises in the Ignatian tradition")
                            //.font(.headline)
                            .font(.system(size:15))
                    }
                }
                .background(Color.black)
                .navigationBarTitle("Pocket Monk")
            }
            .listStyle(.grouped)
            .alert(isPresented: $verseVM.hasError, error: verseVM.error) {
                Text("")
            } // .alert addresses error handling
        }.environment(\.defaultMinListRowHeight, 80)
        .ignoresSafeArea()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView().environment(\.colorScheme, .dark)
        }
    }
}
