//
//  NetworkController.swift
//  DisneyJSONSerialization
//
//  Created by Esther on 6/14/23.
//

import Foundation
class NetworkController {
    private static let urlString = "https://api.disneyapi.dev/character"
    
    static func fetchCharacters(completion: @escaping ([DisneyCharacter]?) -> Void){
        // URL
        guard let finalURL = URL(string: urlString) else {
            completion(nil)
            return
        }
        print(finalURL)
        
        // Data Task
        URLSession.shared.dataTask(with: finalURL) { dTaskData, _, error in
            // Handle error
            if let error {
                print("There was an error with the data task, \(error.localizedDescription)")
                completion(nil)
            }
            // Check for data
            guard let data = dTaskData else {
                completion(nil)
                return
            }
            // Now that data is confirmed, convert it to a JSON object (do, try, catch)
            do {
                /// Karl believes this topLevelDictionary should be passed to Model object to take care of its data rather than parsing it within the function here on the Model Controller. Create fail-able initializer in model file
                /// DO NOT NEED to Catch if we OPTIONALLY Try
                guard let topLevelDict = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String:Any],
                      let charactersArray = topLevelDict["data"] as? [[String:Any]] else {
                    completion(nil)
                    return
                }
                // Access data one at a time with for-in loop and create a temporary array to hold onto these individual characters
                var tempCharArray: [DisneyCharacter] = []
                for characterDict in charactersArray {
                    guard let character = DisneyCharacter(dictionary: characterDict) else {
                        completion(nil)
                        return
                    }
                    tempCharArray.append(character)
                }
                // The completion of fetchCharacters when successful once complete with all prerequisite tasks
                completion(tempCharArray)
            }
            // Resume a suspended state of function. Newly initialized tasks begin in suspended state.
        } .resume()
    }
    
    
}
