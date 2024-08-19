//
//  File.swift
//  Find Flags
//
//  Created by Carol Quiterio on 19/08/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var onboardingCompleted: Bool
    
    var body: some View {
        VStack (alignment: .center,
                content: {
                OnboardingViewPage()
            
            Button(action: {
                onboardingCompleted = true
            }) {
                NavigationLink(destination: EntryView(),
                               label: {
                    HStack(
                        alignment: .center,
                        spacing: 4
                    ) {
                        Text(
                            "Começar"
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
            }
        }).padding(
            .horizontal,
            36
        )
        .padding(
            .bottom,
            36
        )
        .padding(
            .top,
            64
        )
        
    }
}

struct OnboardingItemView: View {
    
    let icon: String
    let isSFIcon: Bool
    let title: String
    let description: String
    var body: some View {
        
        HStack {
            HStack {
                if(isSFIcon) {
                    Image(
                        systemName: icon
                    )
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(
                        .accentColor
                    )
                } else {
                    Image(
                        icon
                    )
                    .resizable()
                    .frame(
                        width: 43,
                        height: 43
                    )
                }
            }
            .padding(
                .trailing,
                8
            )
            
            VStack (alignment: .leading,
                    content: {
                Text(
                    title
                )
                .font(
                    .system(
                        size: 17
                    )
                )
                .fontWeight(
                    .semibold
                )
                .padding(
                    .bottom,
                    2
                )
                
                Text(
                    description
                )
                .font(
                    .system(
                        size: 17
                    )
                )
                .foregroundColor(
                    .secondary
                )
            })
        }
    }
}

struct OnboardingViewPage: View {
    var body: some View {
        VStack {
            Image(
                "FlagRecognitionIcon"
            )
            .resizable()
            .frame(
                width: 60,
                height: 60
            )
            
            Text(
                "Boas vindas ao ..."
            )
            .foregroundColor(
                .primary
            )
            .multilineTextAlignment(
                .center
            )
            .font(
                .largeTitle
            )
            .fontWeight(
                .bold
            )
            
            VStack (alignment: .leading,
                    content: {
                OnboardingItemView(
                    icon: "checkmark.circle.badge.questionmark",
                    isSFIcon: true,
                    title: "Adivinhe bandeiras",
                    description: "Veja bandeiras de países do mundo e tente adivinhar qual é qual."
                ).padding(
                    .top,
                    34
                )
                OnboardingItemView(
                    icon: "FlagRecognitionIcon",
                    isSFIcon: false,
                    title: "Reconheça bandeiras",
                    description: "Use a camera para reconhecer e classificar bandeiras no ambiente."
                ).padding(
                    .top,
                    16
                )
                Spacer()
            })
        }.padding(.top, 60)
    }
}


#Preview {
    OnboardingView(
        onboardingCompleted: .constant(
            false
        )
    )
}
