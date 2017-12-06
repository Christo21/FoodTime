//
//  AppDelegate.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 28/11/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        let navigationBarAppearace = UINavigationBar.appearance()
//        navigationBarAppearace.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        navigationBarAppearace.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
//        
//        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "FoodTime")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /////////////Added by Alfian///////////////
    //////////Notification Support/////////////
    func scheduleNotification(_ item: Item) {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: Date(timeIntervalSinceNow: 60))
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "FoodTime"
        
        let remainingTime = calendar.dateComponents([.day,.hour], from: Date(timeIntervalSinceNow: 0), to: item.getExipredDate())
        guard let remainingDay = remainingTime.day else {return}
        guard let remainingHour = remainingTime.hour else {return}
        content.body = "Your \(item.getName()) will be expired in \(remainingDay) day(s) \(remainingHour) hour(s). If you let it, then you will waste your Rp. \(item.price)."
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "myCategory"
        
        //
        
        if let resourcePath = Bundle.main.resourcePath {
            let imgName = "RedApple.jpg"
            let path = resourcePath + "/" + imgName
            print(path)
        }
        
        if let path = Bundle.main.path(forResource: "RedApple", ofType: "jpg") {
            let url = URL(fileURLWithPath: path)
            do {
                let attachment = try UNNotificationAttachment(identifier: "RedApple", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
        //
        let request = UNNotificationRequest(identifier: String(describing: item.getRegistDate()), content: content, trigger: trigger)
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        let remindLaterAction = UNNotificationAction(identifier: "remindLater", title: "Remind me later", options: [])
        let shareAction = UNNotificationAction(identifier: "share", title: "Share", options: [.foreground])
        let category = UNNotificationCategory(identifier: "myCategory", actions: [remindLaterAction,shareAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        UNUserNotificationCenter.current().delegate = self
        
        registerPushNotification()
        return true
    }
    
    
    func deletePendingNotification(_ identifier: [String]){
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications) in
            print(notifications)
        }
        
        //        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["textNotification"])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifier)
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications) in
            print("remaining notification(s): \(notifications)")
        }
    }
    func registerPushNotification(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }else{
                //            self.getNotificationSettings()
            }
        }
    }
    ///////////////////////////////////////////
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        let notificationIdentifier = response.notification.request.identifier
        let buttonIdentifier = response.actionIdentifier
        let request = response.notification.request
        var coreData: CoreDataClass = CoreDataClass(entity: "ItemModel")
        print("Core Data counted: \(coreData.getData().count)")
        
        switch buttonIdentifier {
        case "remindLater":
            let newDate = Date(timeInterval: 60, since: Date())
//            scheduleNotification(Item())
            print(newDate)
        case "share":
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let otherVC = sb.instantiateViewController(withIdentifier: "share")
            window?.rootViewController = otherVC
            print("go to share page")
        default:
            return
        }
        
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("foreground notif")
    }
}

