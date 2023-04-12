//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Gualy, Sofia on 4/12/23.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "Babes Doughnut Co.", neighborhood: "Downtown", desc: "Breakfast and Coffee", lat: 29.883820, long: -97.940010, imageName: "babes"),
    Item(name: "Blue Dahlia Bistro", neighborhood: "Downtown", desc: "European Bistro", lat: 29.883370, long: -97.941180, imageName: "blue dahlia"),
    Item(name: "Cafe on the Square", neighborhood: "Downtown", desc: "American Cafe", lat: 29.883010, long: -97.939860, imageName: "cafe"),
    Item(name: "CRAFThouse Kitchen and Tap", neighborhood: "Downtown", desc: "Pub Fare and Drinks ", lat: 29.884260, long: -97.940110, imageName: "craft"),
    Item(name: "Ikes Love and Sandwiches", neighborhood: "Downtown", desc: "Unique Sandwiches", lat: 29.884530, long: -97.942160, imageName: "ikes")
   
]
    struct Item: Identifiable {
        let id = UUID()
        let name: String
        let neighborhood: String
        let desc: String
        let lat: Double
        let long: Double
        let imageName: String
    }
struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.8833, longitude: -97.9414), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))

    var body: some View {
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.neighborhood)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                
                Map(coordinateRegion: $region, annotationItems: data) { item in
                                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title)
                                        .overlay(
                                            Text(item.name)
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                                .fixedSize(horizontal: true, vertical: false)
                                                .offset(y: 25)
                                        )
                                }
                            }
                            .frame(height: 300)
                            .padding(.bottom, -30)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Downtown SMTX Restaurants")
        }
    }
    }
struct DetailView: View {
    @State private var region: MKCoordinateRegion
       
       init(item: Item) {
           self.item = item
           _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
       }
     let item: Item
             
     var body: some View {
         VStack {
             Image(item.imageName)
                 .resizable()
                 .aspectRatio(contentMode: .fit)
                 .frame(maxWidth: 200)
             Text("Neighborhood: \(item.neighborhood)")
                 .font(.subheadline)
             Text("Description: \(item.desc)")
                 .font(.subheadline)
                 .padding(10)
                 }
                  .navigationTitle(item.name)
                  Spacer()
         Map(coordinateRegion: $region, annotationItems: [item]) { item in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                        .overlay(
                            Text(item.name)
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: true, vertical: false)
                                .offset(y: 25)
                        )
                }
            }
                .frame(height: 300)
                .padding(.bottom, -30)
      }
   }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
