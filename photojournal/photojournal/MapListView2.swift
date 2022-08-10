//
//  MapListView2.swift
//  photojournal
//
//  Created by Megan Korling on 8/8/22.
//

import SwiftUI

//struct MapListView2: View {
//    let location = "Seattle"
//    let apiKey = "pk.1f00c7cb204323568c51950910d520e8"
//    
//    @State var results = [LocationEntry]()
//    
//    func fetchAPI() {
//        let url = URL(string: "https://us1.locationiq.com/v1/search.php?key=\(apiKey)&q=\(location)&format=json&limit=1")
//        URLSession.shared.dataTask(with: url!) { data, response, error in
//            
//            if let data = data {
//                print("in data")
//                
//                if let decodedLocation = try? JSONDecoder().decode([LocationEntry].self, from: data) {
//                    DispatchQueue.main.async {
//                        print("decoding location")
//                        self.results = decodedLocation
//                    }
//                    
//                }
//            }
//        }.resume()
//    }
//    
//    var body: some View {
//        VStack {
//            Text("\(location) has latitude: \($results.lat) and longitude: \($results.lon)")
////            Text("Hello world")
//            Button(action: {
//                fetchAPI()
//            }, label: {
//                Text("Get Coords")
//            })
//        }
//    }
//}
//
//struct LocationEntry: Codable {
//    let lat: String
//    let lon: String
//}
//
//
//
//struct MapListView2_Previews: PreviewProvider {
//    static var previews: some View {
//        MapListView2()
//    }
//}

