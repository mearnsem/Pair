//
//  PersonController.swift
//  PairRandomizer
//
//  Created by Emily Mearns on 7/8/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation

class PersonController {
    
    private let keyPeople = "storedPeople"
    static let sharedController = PersonController()
    
    var people = [Person]()
    var section = [Person]()
    
    init() {
        loadFromPersistentStorage()
    }
    
    func createPerson(name: String) {
        let person = Person(name: name)
        people.append(person)
        saveToPersistentStorage()
    }
    
    func createSection() {
        
    }
    
    func removePerson(person: Person) {
        guard let index = people.indexOf(person) else {return}
        people.removeAtIndex(index)
        saveToPersistentStorage()
    }
    
    func loadFromPersistentStorage() {
        guard let peopleDictionaries = NSUserDefaults.standardUserDefaults().objectForKey(keyPeople) as? [[String: AnyObject]] else {return}
        people = peopleDictionaries.flatMap({Person(dictionary: $0)})
    }
    
    func saveToPersistentStorage() {
        NSUserDefaults.standardUserDefaults().setObject(people.map({$0.dictionaryCopy}), forKey: keyPeople)
    }
}

extension Array {
    mutating func shuffle() {
        for _ in 0..<10 {
            sortInPlace({ (_, _) -> Bool in
                arc4random() < arc4random()
            })
        }
    }
}