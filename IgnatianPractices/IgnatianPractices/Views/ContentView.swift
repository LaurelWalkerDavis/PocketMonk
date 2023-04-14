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
                        }
                        NavigationLink {
                            VerseView(passage: "GOSPEL")
                        } label: {
                            Text("Imaging Prayer")
                        }
                        NavigationLink {
                            ConsolationView()
                        } label: {
                            Text("Examen")
                        }
                    } header: {
                        Text("Daily exercises")
                    }
                }.background(Color.black)
                .navigationBarTitle("Pocket Monk")
            }
            .listStyle(.insetGrouped)
            .padding()
            .alert(isPresented: $verseVM.hasError, error: verseVM.error) {
                Text("")
            } // .alert addresses error handling
        }.ignoresSafeArea()
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
