//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Rachana Pandit on 14/12/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        retriveData()
        updateEmployeeRecord()
        retriveData()
    }
    
    func insertData()
    {
        let managedContext = appDelegate.persistentContainer.viewContext
        let employeeEntity = NSEntityDescription.entity(forEntityName: "Employee", in: managedContext)
        
        for i in 1...3
        {
            let employee = NSManagedObject(entity: employeeEntity!, insertInto: managedContext)
            
            employee.setValue(i, forKey: "empId")
            employee.setValue("Employee -\(i)", forKey: "empName")
            employee.setValue((i * Int(25000.0)), forKey: "empSalary")
        }
        do{
            try managedContext.save()
        }
        catch let errorMessage as NSError{
            print(errorMessage)
        }
    }
    
    func retriveData()
    {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
                
        do {
            let results   = try managedContext.fetch(fetchRequest)
            print(results)
            
            for eachFetchResults in results as! [NSManagedObject]
            {
                print(eachFetchResults.value(forKey: "empName")!)
                print(eachFetchResults.value(forKey: "empId")!)
            }

        } catch let error as NSError {
          print("Could not fetch \(error)")
        }

    }
    
    func updateEmployeeRecord()
    {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchReuestQuerryForUpdate = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Employee")
        fetchReuestQuerryForUpdate.predicate = NSPredicate(format: "empName = %@","Employee -1")
       
        do{
        let employeeObjects = try managedContext.fetch(fetchReuestQuerryForUpdate)
        let employeeObject =  employeeObjects[0] as! NSManagedObject
        employeeObject.setValue("Employee -4", forKey: "empName")
        employeeObject.setValue(27004.23, forKey: "empSalary")
        }
        catch{
            print("Failed to update Employee record")
        }
    }
    func deleteRecords(){
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequestForDelete = NSFetchRequest<NSFetchRequestResult>(en)
    }
}

