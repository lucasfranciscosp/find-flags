import SwiftUI
import SwiftData

struct RandomFlagView: View {
    
    
    @Environment(\.modelContext) private var context
    @Query private var streak: [DataItem]
    
    @Binding var countries: [Country]
    @State var currentCountry: Country
    @State private var options: [String] = []
    @State private var currentStreak: Int = 0
    @State private var maxStreak: Int = 0
    @State var selectedWrong: [String]

    var body: some View {
        VStack {
            if currentCountry.code != "unknown" {
                
                Text("Your best streak: \(streak.first?.maxStreak ?? 0)")
                Text("Your current streak: \(currentStreak)")
                
                Image(currentCountry.code.lowercased())
                    .resizable()
                    .frame(maxHeight: 300)
                    .border(Color.black, width: 0.5)
                    .padding()
                    .scaledToFit()
                     // Ajuste o tamanho conforme necessário
            
                let columns: [GridItem] = [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(options, id: \.self) { buttonTitle in
                        Button(action: {
                            handleButtonPress(buttonTitle)
                        }) {
                            Text(buttonTitle)
                                //.frame(maxWidth: .infinity, maxHeight: .infinity)
                                .frame(width: 150, height: 50)
                                .padding()
                                .background(selectedWrong.contains(buttonTitle) ? .red : Color.customAccentColor)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        .disabled(selectedWrong.contains(buttonTitle))
                        .opacity(selectedWrong.contains(buttonTitle) ? 0.5 : 1.0)
                    }
                }
                .padding()
            } else {
                Text("Carregando...")
                    .onAppear {
                        loadNewCountry()
                        if streak.first == nil {
                            addStreak()
                        }
                    }
            }
        }
    }
    
    func addStreak() {
        
        let streak = DataItem()
        
        context.insert(streak)
    }
    
    private func loadNewCountry() {
        currentCountry = getCountry(countries: countries)
        options = getOptions(country: currentCountry.name, countries: countries)
    }
    
    private func handleButtonPress(_ buttonTitle: String) {
        if buttonTitle == countries.first(where: { $0.name == currentCountry.name })?.name {
            // Acertou
            loadNewCountry()
            selectedWrong = []
            currentStreak += 1
            // maxStreak = max(maxStreak, currentStreak)
            
            if let streak = streak.first {
                streak.updateStreak(currentStreak: currentStreak)
            }
        } else {
            // Errou
            currentStreak = 0
            selectedWrong.append(buttonTitle)
            print("Resposta errada")
        }
        print("\(buttonTitle) tapped")
    }
    
    private func getOptions(country: String, countries: [Country]) -> [String] {
        var options: Set<String> = []
        if let countryName = countries.first(where: { $0.name == country })?.name {
            options.insert(countryName)
        }
        
        while options.count < 4 {
            options.insert(countries.randomElement()?.name ?? "N/A")
        }
        
        return Array(options).shuffled()
    }
    
    private func getCountry(countries: [Country]) -> Country {
        return countries.randomElement() ?? Country(capital: nil, code: "unknown", continent: "unknown", flag1x1: "unknown", flag4x3: "unknown", iso: false, name: "Unknown")
    }
}

//struct RandomFlagView_Previews: PreviewProvider {
//    @State static var sampleCountries: [Country] = [
//        Country(capital: "Kabul", code: "af", continent: "Asia", flag1x1: "flags/1x1/af.svg", flag4x3: "flags/4x3/af.svg", iso: true, name: "Afghanistan"),
//        Country(capital: "Mariehamn", code: "ax", continent: "Europe", flag1x1: "flags/1x1/ax.svg", flag4x3: "flags/4x3/ax.svg", iso: true, name: "Aland Islands")
//    ]
//    
//    static var previews: some View {
//        RandomFlagView(countries: $sampleCountries, currentCountry: <#Country#>)
//    }
//}
