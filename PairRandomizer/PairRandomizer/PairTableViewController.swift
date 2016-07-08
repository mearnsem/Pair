//
//  PairTableViewController.swift
//  PairRandomizer
//
//  Created by Emily Mearns on 7/8/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class PairTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    @IBAction func addPersonButton(sender: AnyObject) {
        var personTextField: UITextField?
        
        let alertController = UIAlertController(title: "Add Person", message: "Add a person to your list", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Name"
            personTextField = textField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Add", style: .Default) { (_) in
            guard let name = personTextField?.text else {return}
            PersonController.sharedController.createPerson(name)
            self.tableView.reloadData()
            print("People: \(PersonController.sharedController.people.count)")
        }
        alertController.addAction(addAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func randomizeButton(sender: AnyObject) {
        PersonController.sharedController.people.shuffle()
        print("Randomized")
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return PersonController.sharedController.people.count / 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("personCell", forIndexPath: indexPath)

        let person = PersonController.sharedController.people[indexPath.row]
        cell.textLabel?.text = person.name

        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let person = PersonController.sharedController.people[indexPath.row]
            PersonController.sharedController.removePerson(person)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    

}
