//
//  Person.swift
//  PairRandomizer
//
//  Created by Emily Mearns on 7/8/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation

class Person: Equatable {
    
    private let keyName = "name"
    
    var name: String
    
    var dictionaryCopy: [String: AnyObject] {
        return [keyName: name]
    }
    
    init(name: String) {
        self.name = name
    }
    
    init?(dictionary: [String: AnyObject]) {
        guard let name = dictionary[keyName] as? String else {return nil}
        self.name = name
    }
}

func ==(lhs:Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name
}