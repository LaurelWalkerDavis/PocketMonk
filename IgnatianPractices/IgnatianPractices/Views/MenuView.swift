//
//  ContentView.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/2/23.
//

import SwiftUI
import FirebaseAuth

struct MenuView: View {
    //@AppStorage("uid") var userID: String = ""
    @ObservedObject var verseVM = VerseViewModel()
    @StateObject var log = AuthenticationViewModel()
    
    var body: some View {
        
        NavigationView {
            List {
                Section {
                    Image("Logo2")
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 500)
                    NavigationLink {
                        LectioDivina()
                    } label: {
                        Text("Lectio Divina")
                            .font(.system(size: 25))
                    }
                    NavigationLink {
                        ImaginativePrayer()
                    } label: {
                        Text("Imaginative Prayer")
                            .font(.system(size: 25))
                    }
                    NavigationLink {
                        Examen()
                    } label: {
                        Text("Examen")
                            .font(.system(size: 25))
                    }
                    NavigationLink {
                        Contemplation()
                    } label: {
                        Text("Contemplation")
                            .font(.system(size: 25))
                    }
                    NavigationLink {
                        LifeReviewView()
                    } label: {
                        Text("Life Review")
                            .font(.system(size: 25))
                    }
                    
                }
            }
            .environment(\.defaultMinListRowHeight, 80)
        }
        
        .listStyle(.grouped)
        .alert(isPresented: $verseVM.hasError, error: verseVM.error) {
            Text("")
        } // .alert addresses error handling
    }
    
    
}



struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuView()
            MenuView().environment(\.colorScheme, .dark)
        }
    }
    
    
}
