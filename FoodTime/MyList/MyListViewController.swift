//
//  MyListViewController.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 04/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

class MyListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var homeSearchBar: UISearchBar!
    @IBOutlet weak var homeTableView: UITableView!
    
    var homeItem:[Item] = []
    var filteredItem = [Item]()
    var itemCoreData: CoreDataClass = CoreDataClass(entity: "ItemModel")
    var userCoreData: CoreDataClass = CoreDataClass(entity: "UserModel")
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! HomeTableViewCell
        
        cell.detailImage.image? = UIImage(named: filteredItem[indexPath.row].getImage())!
        cell.expiredDateOfImage.text = String(String(describing: filteredItem[indexPath.row].getExipredDate()).prefix(19))
        cell.imageName.text = filteredItem[indexPath.row].getName()
        cell.noteOfImage.text = filteredItem[indexPath.row].getNote()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (ac, view, success) in
            //should be link to share view
            success(true)
        }
        shareAction.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [shareAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit"){ (ac, view, success)in
            //should be linked to edit menu
            success(true)
        }
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (ac, view, success) in
            self.filteredItem.remove(at: indexPath.row)
            self.homeTableView.reloadData()
            success(true)
        }
        editAction.backgroundColor = .orange
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredItem = homeItem
            self.homeTableView.reloadData()
        }else{
            filteredItem = homeItem.filter{ $0.getName().lowercased().contains(searchText.lowercased())
            }
            self.homeTableView.reloadData()
        }
    }
    func loadItems(){
        let Burger: Item = Item(name: "Burger", quantity: 2, image: "camera", price: 20000, note: "This is your Burger", registDate: Date(timeIntervalSinceNow: 0), expiredDate: Date(timeIntervalSinceNow: 60*60*24*4))
        
        var items: [Item] = []
        items.append(Burger)
//        homeItem = items
        
        
        
        let dataStoredCount = itemCoreData.getData().count
        for itemStored in itemCoreData.getData() {
            homeItem.append(Item(item: itemStored))
        }
        
        let dataTempCount = homeItem.count
        print("stored: \(dataStoredCount) | temp: \(dataTempCount)")
        
        delegate?.scheduleNotification(Burger)
//        let coreData: CoreDataClass = CoreDataClass(entity: "ItemModel")
//        coreData.clearData()
//        coreData.saveData(object: Burger)
//        print(coreData.getData()[0].value(forKey: "name"))
//        coreData.updateData(object: Risole)
//        print(coreData.getData()[0].value(forKey: "name"))
//        coreData.deleteData(key: "registDate", value: Date(timeIntervalSinceNow: 0))
//        print(coreData.getData().count)
//        coreData.clearData()
//
//        let coreDataUser: CoreDataClass = CoreDataClass(entity: "UserModel")
//        coreDataUser.clearData()
//        var usr = User(name: "alpian", password: "123", address: "cibi", id: "pian.com")
//        coreDataUser.saveData(object: usr)
//        print(coreDataUser.getData()[0].value(forKey: "password")!)
//        usr.setPassword(password: "321")
//        coreDataUser.updateData(object: usr)
//        print("re: \(coreDataUser.getData()[0].value(forKey: "password")!)")
//        print(coreDataUser.getData().count)
    }
    
    let delegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarItem()
        loadItems()
        filteredItem = homeItem
        homeTableView.reloadData()
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.homeSearchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func setupNavigationBarItem(){
        //kiri
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"mail"), style: .plain, target: self, action: #selector(addTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"plus"), style: .plain, target: self, action: #selector(addTapped))
        
    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "addItem", sender: nil)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

