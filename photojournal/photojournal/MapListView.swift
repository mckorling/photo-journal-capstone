//
//  MapListView.swift
//  photojournal
//
//  Created by Megan Korling on 8/8/22.
//

import SwiftUI


//
struct MapListView: View {
    let location = "seattle"
//    let apiKey = "pk.1f00c7cb204323568c51950910d520e8"
////    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String

    @State var latitude = String()
    @State var longitude = String()
//
//    func formatLocString(location: String) -> String {
//        let locArray = location.components(separatedBy: " ")
//        let formatted = locArray.joined(separator: "+")
//        return formatted
//    }
//
//    func fetchAPI() {
//        let url = URL(string: "https://us1.locationiq.com/v1/search.php?key=\(String(describing: apiKey))&q=\(formatLocString(location: location))&format=json&limit=1")
//        URLSession.shared.dataTask(with: url!) { data, response, error in
//            DispatchQueue.main.async {
//                if let data = data {
//                    if let decodedLocation = try? JSONDecoder().decode([Result].self, from: data) {
//                            self.latitude = decodedLocation[0].lat
//                            self.longitude = decodedLocation[0].lon
//                    }
//                    else { // error
//                        self.latitude = "0"
//                        self.longitude = "0"
//                    }
//                }
//            }
//        }.resume()
//    }
//
    var body: some View {
        VStack {
            Text("\(location) has latitude: \(latitude) and longitude: \(self.longitude)")
//            Text("Hello world")
            Button(action: {
                latitude = "hi"
            }, label: {
                Text("Get Coords")
            })
        }
    }
}
//
//struct Result: Decodable {
//    var lat: String
//    var lon: String
//}
//
//
//
//struct MapListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapListView()
//    }
//}
