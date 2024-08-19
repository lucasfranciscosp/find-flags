//
//  CreditsView.swift
//  Find Flags
//
//  Created by Carol Quiterio on 19/08/24.
//

import SwiftUI


struct CreditsButton: View {

    @State private var isPresentingCreditsSheet = false
    
    var body: some View {
        VStack {
            
            Image(systemName: "info.circle")
                .resizable()
                .frame(width: 22, height: 22)
                .fontWeight(.regular)
                .foregroundColor(.accentColor)
                .onTapGesture {
                    isPresentingCreditsSheet = true
                }
        }.sheet(
            isPresented: Binding<Bool>(
                get: {
                    isPresentingCreditsSheet },
                set: { _ in }
            ),
            
            content: {
                CreditsView(isPresentingCreditsSheet: $isPresentingCreditsSheet).presentationDetents([.fraction(0.9)])
                    .onDisappear(
                    perform: { isPresentingCreditsSheet = false
                    }
                )
            })
    }
}

struct CreditsView: View {
    @Binding var isPresentingCreditsSheet: Bool
    
    var body: some View {
            VStack (alignment: .center, content: {
                
                HStack(content: {
                    Spacer()
                    Text("Sobre")
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .foregroundColor(.accentColor)
                        .frame(width: 22, height: 22)
                        .fontWeight(.semibold)
                        .onTapGesture {
                            isPresentingCreditsSheet = false
                        }
                })
                .padding()
                
                VStack (alignment: .leading, content: {
                    HStack {
                        Image("FlagRecognitionIcon")
                            .resizable()
                            .frame(width: 46, height: 46)
                            .foregroundColor(.accentColor)
                            .padding(.trailing, 10)
                        VStack (alignment: .leading, content: {
                            Text("Sobre o App")
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .padding(.bottom, 2)
                            
                            Text("... é um aplicativo educacional idealizado para ajudar pessoas a aprender e reconhecer bandeiras do mundo.")
                                .font(.system(size: 17))
                                .foregroundColor(.secondary)
                        })
                    }
                    VStack (alignment: .leading, content: {
                        
                        AutorItem(
                            img: "Carol",
                            isFirst: true,
                            description: "Carolina é uma estudante da Apple Developer Academy e de  Sistemas de Informação na Unicamp."
                        )
                        AutorItem(
                            img: "Joao",
                            isFirst: false,
                            description: "João Gonçalves is an Computer Science  Student at Unicamp and Apple Developer Academy Student."
                        )
                        AutorItem(
                            img: "Lucas",
                            isFirst: false,
                            description: "Lucas Francisco is a Computer Science Student at Unicamp and Apple Developer Academy Student."
                        )
                        AutorItem(
                            img: "Sil",
                            isFirst: false,
                            description: "Silvana Alves is a Applied Matemathics Student at Unicamp and Apple Developer Academy Student."
                        )
                
                    }).padding(.top, 24)
                    HStack {
                        Spacer()
                        Text("Feito com 🤎 by")
                            .foregroundColor(.secondary)
                        
                            Spacer()
                    }.padding(.top)
                    HStack {
                        Spacer()
                        HStack {
                            Link("Carolina", destination: URL(string: "https://br.linkedin.com/in/carolquiterio")!)
                                .foregroundColor(.accentColor)
                                .bold()
                                .padding(-4)
                            Text(", ")
                                .foregroundColor(.secondary)
                                .padding(-4)
                            Link("João", destination: URL(string: "https://www.linkedin.com/in/joaovitorgoncalvesoliveira")!)
                                .bold()
                                .padding(-4)
                            Text(", ")
                                .foregroundColor(.secondary)
                                .padding(-4)
                            Link("Lucas", destination: URL(string: "https://br.linkedin.com/in/lucasfrancisco1")!)
                                .bold()
                                .padding(-4)
                            Text("and")
                                .foregroundColor(.secondary)
                            Link("Silvana", destination: URL(string: "https://br.linkedin.com/in/silvana-alves")!)
                                .bold()
                                .padding(-4)
                        }.padding(.bottom)
                        Spacer()
                    }
                })
                .padding()
            })
            .accentColor(.customAccentColor)
        }
}

#Preview {
    CreditsView(isPresentingCreditsSheet: .constant(true))
}


struct AutorItem: View {
    let img: String
    let isFirst: Bool
    let description: String
    
    var body: some View {
        HStack {
            Image(img)
                .resizable()
                .frame(width: 60, height: 60)
                .padding(.trailing, 10)
            VStack (alignment: .leading, content: {
                if (isFirst) {
                    Text("Sobre os autores")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .padding(.bottom, 2)
                }
                Text(description)
                    .font(.system(size: 17))
                    .foregroundColor(.secondary)
            })
        }
    }
    
}
