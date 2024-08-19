import Foundation

struct Country: Identifiable, Codable {
    let id = UUID() // Adiciona um identificador único para a visualização
    let capital: String?
    let code: String
    let continent: String?
    let flag1x1: String
    let flag4x3: String
    let iso: Bool
    let name: String

    enum CodingKeys: String, CodingKey {
        case capital
        case code
        case continent
        case flag1x1 = "flag_1x1"
        case flag4x3 = "flag_4x3"
        case iso
        case name
    }
}


struct CountryParser {
    
//    func parseCountries() -> [String: String] {
//        if let fileURL = Bundle.main.url(forResource: "countries", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: fileURL)
//                let countries = try JSONDecoder().decode([String: String].self, from: data)
//                
//                // Iterar sobre todos os pares chave-valor no dicionário
////                for (code, country) in countries {
////                    print("Código: \(code), País: \(country)")
////                }
//                
//                return countries
//            } catch {
//                print("Erro ao carregar ou decodificar JSON: \(error)")
//            }
//        } else {
//            print("Arquivo 'countries.json' não encontrado.")
//        }
//        return [:]
//    }
    
    func loadCountries() -> [Country] {
            guard let url = Bundle.main.url(forResource: "country_pt", withExtension: "json") else {
                print("JSON file not found")
                return []
            }

            do {
                var countries: [Country] = []
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                countries = try decoder.decode([Country].self, from: data)
                return countries
            } catch {
                print("Error decoding JSON: \(error)")
            }
        
    return []
        }
}

//// Criar uma instância da struct e chamar o método parseCountries
//let parser = CountryParser()
//parser.parseCountries()
