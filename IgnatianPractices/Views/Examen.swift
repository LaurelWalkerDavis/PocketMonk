//
//  Examen.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/14/23.
//

import SwiftUI

struct Examen: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Examen")
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                Section {
                    Text("The Examen is one of the most notable Ignatian practices. It involves a contemplative reflection on your day. It consists of two major parts: a review of consolations and desolations.")
                }header: {
                    Text("Exercise Description")
                        .font(.system(size: 18))
                }
                Section {
                    Text("Review your day and note 2 or 3 consolations you experienced. Then, note at least 1 desolation you experienced.")
                }header: {
                    Text("Instructions")
                        .font(.system(size: 18))
                }
                
                Section {
                    NavigationLink {
                        ConsolationView()
                    } label: {
                        Text("Consolations")
                            .font(.system(size: 25))
                    }
                }
                Section {
                    NavigationLink {
                        DesolationsView()
                    } label: {
                        Text("Desolations")
                            .font(.system(size: 25))
                    }
                }
            }
        }
    }
    
    struct Examen_Previews: PreviewProvider {
        static var previews: some View {
            Examen()
        }
    }
}
