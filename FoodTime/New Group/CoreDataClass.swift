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
    func saveData(object: AnyObject) {
        if object is Item {
            
        }else if object is Share{
            
        }
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
    
    func deleteData(key: String, value: Int) {
        let dataFetch = NSFetchRequest<NSFetchRequestResult>(entityName: coreDataEntityName)
        var isDeleted: Bool = false
        do{
            let dataArray: [NSManagedObject] = try container.fetch(dataFetch) as! [NSManagedObject]
            
            for data in dataArray {
                if let intData = data.value(forKey: key) as? Int {
                    if intData == value {
                        container.delete(data)
                        isDeleted = true
                        print("1 item deleted, INT process")
                        break
                    }
                }
            }
            
        }catch let error as NSError{
            print(error)
        }
        if !isDeleted {print("no data is deleted with [key:\"\(key)\",value:\(value)]"); return}
        savePersistent()
    }
    func deleteData(key: String, value: Date) {
        let dataFetch = NSFetchRequest<NSFetchRequestResult>(entityName: coreDataEntityName)
        var isDeleted: Bool = false
        do{
            let dataArray: [NSManagedObject] = try container.fetch(dataFetch) as! [NSManagedObject]
            
            for data in dataArray {
                if let dateData = data.value(forKey: key) as? Date {
                    if dateData == value {
                        container.delete(data)
                        isDeleted = true
                        print("1 item deleted, DATE process")
                        break
                    }
                }
            }
            
        }catch let error as NSError{
            print(error)
        }
        if !isDeleted {print("no data is deleted with [key:\"\(key)\",value:\(value)]"); return}
        savePersistent()
    }
    func deleteData(key: String, value: String) {
        let dataFetch = NSFetchRequest<NSFetchRequestResult>(entityName: coreDataEntityName)
        var isDeleted: Bool = false
        do{
            let dataArray: [NSManagedObject] = try container.fetch(dataFetch) as! [NSManagedObject]
            
            for data in dataArray {
                guard let unData = data.value(forKey: key) else{
                    print("error guarding")
                    return
                }
                if String(describing: unData) == value {
                    container.delete(data)
                    isDeleted = true
                    print("\(unData) deleted, STRING process")
                    break
                }
            }
            
        }catch let error as NSError{
            print(error)
        }
        if !isDeleted {print("no data is deleted with [key:\"\(key)\",value:\"\(value)\"]"); return}
        savePersistent()
    }
    
////////////TEMP CODE///////
//    func deleteData(key: String, value: Any) {
//        let dataFetch = NSFetchRequest<NSFetchRequestResult>(entityName: coreDataEntityName)
//        do{
//            let dataArray: [NSManagedObject] = try container.fetch(dataFetch) as! [NSManagedObject]
//            if value is String {
//                print("IN STRING")
//                for data in dataArray {
//                    guard let unData = data.value(forKey: key) else{
//                        print("error guarding")
//                        return
//                    }
//                    if String(describing: unData) == (value as! String) {
//                        container.delete(data)
//                        print("\(unData) deleted, STRING process")
//                        break
//                    }
//                }
//            }else if value is Int {
//                if let intValue = value as? Int {
//                    print("IN INT")
//                    for data in dataArray {
//                        if let intData = data.value(forKey: key) as? Int {
//                            if intData == intValue {
//                                container.delete(data)
//                                print("1 item deleted, INT process")
//                                break
//                            }
//                        }
//                    }
//                }
//
//            }else if value is Date {
//                if let dateValue = value as? Date {
//                    print("IN DATE")
//                    for data in dataArray {
//                        if let dateData = data.value(forKey: key) as? Date {
//                            if dateData == dateValue {
//                                container.delete(data)
//                                print("1 item deleted, DATE process")
//                                break
//                            }
//                        }
//                    }
//                }
//            }
//
//        }catch let error as NSError{
//            print(error)
//        }
//        savePersistent()
//    }
//////////////////////////////
    
    func clearData() {
        let dataFetch = NSFetchRequest<NSFetchRequestResult>(entityName: coreDataEntityName)
        var countDeleted = 0
        do{
            let dataArray: [NSManagedObject] = try container.fetch(dataFetch) as! [NSManagedObject]
            print("start clearing the data")
            if dataArray.count == 0 {
                print("no data to be deleted. done clearing the data.")
                return
            }
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

