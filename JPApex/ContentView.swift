//
//  ContentView.swift
//  JPApex
//
//  Created by Bholanath Barik on 02/04/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let predators = Predators();
    @State var searchText = "";
    @State var alphabetical = false;
    @State var currentSelection = ProdiorType.all;
    
    var filterData: [ApexPredator] {
        predators.filter(by: currentSelection);
        predators.sort(by: alphabetical);
        return predators.search(for: searchText);
    }
    
    var body: some View {
        NavigationStack {
            List(filterData) { Predator in
                NavigationLink{
                    PredatorDetails(predator: Predator, 
                                    position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 30000)));
                }label: {
                    HStack{
                        Image(Predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading){
                            Text(Predator.name)
                                .fontWeight(.bold)
                            
                            Text(Predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal,13)
                                .padding(.vertical, 5)
                                .background(Predator.type.background)
                                .clipShape(.capsule)
                            
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation{
                            alphabetical.toggle();
                        }
                    } label: {
                        Image(systemName : alphabetical ? "film" :  "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                
                ToolbarItem(placement : .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentSelection.animation()){
                            ForEach(ProdiorType.allCases) { type in
                                Label(type.rawValue.capitalized ,
                                      systemImage: type.icon)
                            }
                        }
                    }label: {
                        Image(systemName: "slider.horizontal.3");
                    }
                }
            }
            
        }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
    
}

#Preview {
    ContentView()
}
