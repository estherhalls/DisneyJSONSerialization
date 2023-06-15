//
//  DisneyCharacter.swift
//  DisneyJSONSerialization
//
//  Created by Esther on 6/14/23.
//

import Foundation

class DisneyCharacter {
    // Parameters we chose to declare for our app from the character endpoint of the Disney API
    let name: String
    let imageURL: String?
    
    // Memberwise Initializer (Designated initializer)
    init(name: String, imageURL: String?) {
        self.name = name
        self.imageURL = imageURL
    }
} // End of Class

extension DisneyCharacter {
    
    // Convenience Initializer - to use when Convenient for you
    /// Even though API is String:String dictionary, it is far safer to pass in a value type of 'Any' and then optionally typecast as the individual types in case the API introduces new data of a different type in the future.
    convenience init?(dictionary: [String:Any]) {
        /// as? = type cast; ["xxx"] = subscript syntax
        guard let name = dictionary["name"] as? String,
              let imageURL = dictionary["imageUrl"] as? String else {
            return nil
        }
        /// Convenience initializer must always still use designated intializer
        self.init(name: name, imageURL: imageURL)
    }
} // End of Extension
