//
//  CoreDataClass.swift
//  NotificationsUI
//
//  Created by Alfian WIjayakusuma on 12/5/17.
//  Copyright © 2017 Pranjal Satija. All rights reserved.
//

import UIKit
import CoreData

class CoreDataClass  {
    init(entity: String) {
        coreDataEntityName = entity
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        container = appDelegate.persistentContainer.viewContext
        
        //isi container, pilih dl tabelnya
        dataEntity = NSEntityDescription.entity(forEntityName: coreDataEntityName, in: container)
    }
    
    let appDelegate: AppDelegate
    let container: NSManagedObjectContext
    var coreDataEntityName: String
    let dataEntity: NSEntityDescription?
    
    func savePersistent() {
        do{
            try container.save()
            print("saving complete")
        }catch let error as NSError{
            print(error)
        }
    }
    
    func saveData(pairData: [String:Any]) {
        //NSManagedObject = buat instance baru untuk disimpan
        let newData = NSManagedObject(entity: dataEntity!, insertInto: container)
        for (key, value) in pairData {
            newData.setValue(value, forKey: key)
        }
        savePersistent()
    }
    
    func getData() -> [NSManagedObject] {
        let dataFetch = NSFetchRequest<NSFetchRequestResult>(entityName: coreDataEntityName)
        do{
            let dataArray: [NSManagedObject] = try container.fetch(dataFetch) as! [NSManagedObject]
            return dataArray
        }catch let error as NSError{
            print(error)
            return [NSManagedObject()]
        }
    }
    
    func deleteData(key: String, value: String) {
        let dataFetch = NSFetchRequest<NSFetchRequestResult>(entityName: coreDataEntityName)
        do{
            let dataArray: [NSManagedObject] = try container.fetch(dataFetch) as! [NSManagedObject]
            
            for data in dataArray {
                guard let unData = data.value(forKey: key) else{
                    print("error guarding")
                    return
                }
                if String(describing: unData) == value {
                    container.delete(data)
                    print("\(unData) deleted")
                    break
                }else{
                    //                    print(unData.value(forKey: "name"))
                }
            }
        }catch let error as NSError{
            print(error)
        }
        savePersistent()
    }
    func deleteData(key: String, value: Int) {
        let dataFetch = NSFetchRequest<NSFetchRequestResult>(entityName: coreDataEntityName)
        do{
            let dataArray: [NSManagedObject] = try container.fetch(dataFetch) as! [NSManagedObject]
            
            for data in dataArray {
                if Int(String(describing: data.value(forKey: key))) == value {
                    container.delete(data)
                    print("1 item deleted")
                    break
                }else{
                    //                    print(unData.value(forKey: "name"))
                }
            }
        }catch let error as NSError{
            print(error)
        }
        savePersistent()
    }
    
    func clearData() {
        let dataFetch = NSFetchRequest<NSFetchRequestResult>(entityName: coreDataEntityName)
        var countDeleted = 0
        do{
            let dataArray: [NSManagedObject] = try container.fetch(dataFetch) as! [NSManagedObject]
            
            for data in dataArray {
                container.delete(data)
                guard let unData = data.value(forKey: "name") else {
                    print("error guarding")
                    return
                }
                print("\(unData) deleted")
                countDeleted += 1
            }
        }catch let error as NSError{
            print(error)
        }
        savePersistent()
        print("clearing \(countDeleted) data complete")
    }
}

