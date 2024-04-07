//
//  Predators.swift
//  JPApex
//
//  Created by Bholanath Barik on 03/04/24.
//

import Foundation

class Predators {
    var allApexPredators : [ApexPredator] = []
    var apexPredators : [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            do {
                let data = try Data(contentsOf: url);
                let decoder = JSONDecoder();
                decoder.keyDecodingStrategy = .convertFromSnakeCase;
                allApexPredators = try decoder.decode([ApexPredator].self, from: data);
                apexPredators = allApexPredators
            } catch {
                print("Error decoding Json data : \(error)");
            }
        }
    }
    
    func search(for searchTerm : String) -> [ApexPredator] {
        if searchTerm.isEmpty{
            return apexPredators;
        }else{
            return apexPredators.filter{
                predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm);
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { Predator1 , Predator2 in
            if alphabetical {
                Predator1.name < Predator2.name;
            }else{
                Predator1.id < Predator2.id;
            }
        }
    }
    
    func filter(by type : ProdiorType) {
        if(type != .all){
            apexPredators = allApexPredators.filter { predator in
                predator.type == type
            }
        }else{
            apexPredators = allApexPredators;
        }
    }
}
