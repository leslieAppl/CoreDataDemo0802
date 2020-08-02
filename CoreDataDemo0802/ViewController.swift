//
//  ViewController.swift
//  CoreDataDemo0802
//
//  Created by leslie on 8/2/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var statusLbl: UILabel!
    
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCoreStack()
    }

    //TODO: - 1 Initializing the Persistent Container
    func initCoreStack() {
        
        let container = NSPersistentContainer(name: "CoreDataDemo0802")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            } else {
                self.managedObjectContext = container.viewContext
            }
        }
    }
    
    //TODO: - 2 Saving Data to the persistent store using Core Data
    @IBAction func saveBtnPressed(_ sender: UIButton) {

        if let context = self.managedObjectContext, let entityDescription = NSEntityDescription.entity(forEntityName: "Contacts", in: context) {

            let contact = Contacts(entity: entityDescription, insertInto: managedObjectContext)
            contact.name = name.text
            contact.address = address.text
            contact.phone = phone.text

            do {
                try managedObjectContext?.save()
                name.text = ""
                address.text = ""
                phone.text = ""

                statusLbl.text = "Contact Saved"
            } catch {
                statusLbl.text = error.localizedDescription
            }
        }
    }
    
    @IBAction func findBtnPressed(_ sender: UIButton) {
        
    }
}

