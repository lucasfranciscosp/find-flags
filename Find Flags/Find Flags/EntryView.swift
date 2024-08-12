//
//  EntryView.swift
//  Find Flags
//
//  Created by Lucas Francisco on 08/08/24.
//

import SwiftUI

struct EntryView: View {
    @State var countries: [Country] = []
    @State var country = Country(capital: "", code: "unknown", continent: "", flag1x1: "", flag4x3: "", iso: false, name: "nada")
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Flags")
                    .padding()
                
                // Navegar para RandomFlagView usando NavigationLink
                NavigationLink(destination: RandomFlagView(countries: $countries, currentCountry: country, selectedWrong: [])) {
                    Text("Play")
                        .padding()
                }
                
                Button {
                    // Ação para "Credits"
                } label: {
                    Text("Credits")
                        .padding()
                }
            }
        }
        .onAppear{
            let parser = CountryParser()
            countries = parser.loadCountries()
            print("Estou printando countries", countries)
        }
    }
}

#Preview {
    EntryView()
}
