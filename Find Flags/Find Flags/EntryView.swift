//
//  EntryView.swift
//  Find Flags
//
//  Created by Lucas Francisco on 08/08/24.
//

import SwiftUI

struct EntryView: View {
    @State var countries: [Country] = []
    @State var country = Country(
        capital: "",
        code: "unknown",
        continent: "",
        flag1x1: "",
        flag4x3: "",
        iso: false,
        name: "nada"
    )
    
    var body: some View {
            VStack {
                Image("Icon")
                    .resizable()
                    .frame(maxWidth: 350, maxHeight: 300)
                NavigationLink(destination: RandomFlagView(
                    countries: $countries,
                    currentCountry: country,
                    selectedWrong: []
                ).accentColor(.customAccentColor),
                               label: {
                    HStack(
                        alignment: .center,
                        spacing: 4
                    ) {
                        Image(
                            systemName: "play.fill"
                        )
                        .foregroundColor(
                            .white
                        )
                        Text(
                            "Jogar"
                        )
                        .font(
                            .system(
                                size: 16
                            )
                        )
                        .fontWeight(
                            .semibold
                        )
                        .foregroundColor(
                            .white
                        )
                    }
                    .frame(
                        maxWidth: .infinity
                    )
                    .padding(
                        .horizontal,
                        20
                    )
                    .padding(
                        .vertical,
                        14
                    )
                    .background(
                        Color.customAccentColor
                    )
                    .cornerRadius(
                        40
                    )
                })
                
                //                NavigationLink(destination: CameraView(classifier: ImageClassifier()).accentColor(.customAccentColor),
                //                               label: {
                //                    HStack(
                //                        alignment: .center,
                //                        spacing: 4
                //                    ) {
                //                        Text(
                //                            "Reconhecer bandeira"
                //                        )
                //                        .font(
                //                            .system(
                //                                size: 16
                //                            )
                //                        )
                //                        .fontWeight(
                //                            .semibold
                //                        )
                //                        .foregroundColor(
                //                            .accentColor
                //                        )
                //                    }
                //                    .frame(
                //                        maxWidth: .infinity
                //                    )
                //                    .padding(
                //                        .horizontal,
                //                        20
                //                    )
                //                    .padding(
                //                        .vertical,
                //                        14
                //                    )
                //                    .background(
                //                        .background.secondary
                //                    )
                //                    .cornerRadius(
                //                        40
                //                    )
                //                })
            }.padding()
            
                .onAppear{
                    let parser = CountryParser()
                    countries = parser.loadCountries()
                    print(
                        "Estou printando countries",
                        countries
                    )
                }
                .navigationTitle(
                    "Bandeiras"
                )
                .navigationBarItems(
                    trailing: HStack {
                        Spacer()
                        CreditsButton().padding(
                            .horizontal,
                            12
                        )
                    }
                )
    }
}

#Preview {
    EntryView()
}
