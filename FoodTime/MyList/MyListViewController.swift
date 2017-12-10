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
    var receivedItem = [Item]()
    var itemCoreData: CoreDataClass = CoreDataClass(entity: "ItemModel")
    var userCoreData: CoreDataClass = CoreDataClass(entity: "UserModel")
    
    let delegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isEmpty()
        setupNavigationBarItem()
        loadItems()
        filteredItem = homeItem
        homeTableView.reloadData()
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.homeSearchBar.delegate = self
        hideKeyboardWhenTappedAround()
        
    }
    
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        reload()
        filteredItem = homeItem
        isEmpty()
        homeTableView.reloadData()
    }
    func isEmpty() {
        if filteredItem.count > 0 {
            emptyView.isHidden = true
        } else {
            emptyView.isHidden = false
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! HomeTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+7:00")
        let newDate = dateFormatter.string(from: filteredItem[indexPath.row].getExipredDate())
        
        
        let dataDecoded : Data = Data(base64Encoded: filteredItem[indexPath.row].getImage(), options: .ignoreUnknownCharacters)!
        
        let qty = filteredItem[indexPath.row].getQuantity()
        
        cell.detailImage.image = UIImage(data: dataDecoded as Data)!
        cell.detailImage.layer.cornerRadius = 8
        cell.detailImage.clipsToBounds = true
        
        cell.expiredDateOfImage.text = "Expired in \(newDate)"
        cell.imageName.text = filteredItem[indexPath.row].getName()
        cell.noteOfImage.text = filteredItem[indexPath.row].getNote()
        cell.noteOfImage.sizeToFit()
        cell.qty.text = "・qty: \(filteredItem[indexPath.row].getQuantity())"
        
        cell.indicator.textColor = colorOfIndicator(item: filteredItem[indexPath.row])
        
        return cell
    }
    
    //menentukan warna indikator
    func colorOfIndicator(item: Item) -> UIColor {
        let calendar = NSCalendar.current
        let date1 = calendar.startOfDay(for: item.getRegistDate())
        let date2 = calendar.startOfDay(for: item.getExipredDate())
        let dateNow = Date()
        
        //print("DEBUG INDICATOR || date1 : \(date1), date 2 : \(date2), now : \(dateNow)")
        
        let minute: Double = Double(calendar.dateComponents([.second], from: date1, to: date2).second!)
        let now: Double = Double(calendar.dateComponents([.second], from: dateNow, to: date2).second!)
        
        //print("\(minute) \(now)")
        
        if now > minute * 0.7 {
            return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else if now > minute * 0.3 {
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else {
            return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (ac, view, success) in
            self.sharingItem = self.filteredItem[indexPath.row]
            self.performSegue(withIdentifier: "ShareItem", sender: nil)
            success(true)
        }
        shareAction.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)
        return UISwipeActionsConfiguration(actions: [shareAction])
    }
    
    var editingItem: Item!
    var sharingItem: Item!
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit"){ (ac, view, success)in
            self.editingItem = self.filteredItem[indexPath.row]
            self.performSegue(withIdentifier: "EditItem", sender: nil)
            success(true)
        }
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (ac, view, success) in
            self.itemCoreData.deleteData(key: "registDate", value: self.filteredItem[indexPath.row].getRegistDate())
            self.filteredItem.remove(at: indexPath.row)
            self.homeItem.remove(at: indexPath.row)
            self.isEmpty()
            self.homeTableView.reloadData()
            success(true)
        }
        editAction.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.6117647059, blue: 0.07058823529, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
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
    override var canBecomeFirstResponder: Bool {
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        self.becomeFirstResponder()
    }
    
    func reload() {
        let dataStored = itemCoreData.getData()
        let dataStoredCount = itemCoreData.getData().count
        
        if dataStoredCount > homeItem.count && homeItem.count == filteredItem.count{
            let newItem = dataStored[dataStoredCount - 1]
            let newItemDate = newItem.value(forKey: "expiredDate") as! Date
            
            
            //masukin data sesuai urutan
            if dataStoredCount > 1 {
                for index in 0...homeItem.count{
                    if index == homeItem.count - 1{
                        homeItem.append(Item(item: newItem))
                        break
                    }
                    let oldItem = homeItem[index].getExipredDate()
                    let afterOldItem = homeItem[index+1].getExipredDate()
                    
                        let dateNow = Date()
                        let calendar = NSCalendar.current
                        let newItemInDay: Int = Int(calendar.dateComponents([.day], from: dateNow, to: newItemDate).day!)
                        let oldItemInDay: Int = Int(calendar.dateComponents([.day], from: dateNow, to: oldItem).day!)
                        let afterOldItemInDay: Int = Int(calendar.dateComponents([.day], from: dateNow, to: afterOldItem).day!)
                    
                        //print("DEBUG INSERT ITEM || new: \(newItemInDay) old: \(oldItemInDay) after: \(afterOldItemInDay)")
                        if newItemInDay > oldItemInDay && newItemInDay <= afterOldItemInDay{
                            homeItem.insert(Item(item: newItem), at: index + 1)
                            break
                        } else if newItemInDay < oldItemInDay && newItemInDay <= afterOldItemInDay{
                            homeItem.insert(Item(item: newItem), at: index)
                            break
                        }
                }
            } else {
                homeItem.append(Item(item: newItem))
            }
        }
    }
    
    func sorterForFileIDASC(this:Item, that:Item) -> Bool {
        return this.getExipredDate() < that.getExipredDate()
    }
    
    func loadItems(){
        let dataStored = itemCoreData.getData()
        let dataStoredCount = dataStored.count
        
        for itemStored in dataStored{
           // print("yg ada di list \(itemStored.value(forKey: "registDate"))")
            homeItem.append(Item(item: itemStored))
        }
        
        homeItem.sort(by: sorterForFileIDASC(this:that:))
        
        let dataTempCount = homeItem.count
        //print("stored: \(dataStoredCount) | temp: \(dataTempCount)")
        
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
    
    public func setupNavigationBarItem(){
        //kiri
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"mail"), style: .plain, target: self, action: #selector(messageTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"plus"), style: .plain, target: self, action: #selector(addTapped))
        
    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "addItem", sender: nil)
    }
    @objc func messageTapped(sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "LoginFromMyList", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItem" {
            let destination = segue.destination as! AddFormViewController
            destination.editName = editingItem.getName()
            destination.editDate = editingItem.getExipredDate()
            destination.editPic = editingItem.getUIImage()
            //destination.qtyPicker
            destination.editPrice = String(describing: editingItem.getPrice())
            destination.editNote = editingItem.getNote()
            destination.titleForm = "Edit Item"
        }
        if segue.identifier == "ShareItem" {
            let destination = segue.destination as! ShareFormViewController
            destination.shareName = sharingItem.getName()
            destination.shareDate = sharingItem.getExipredDate()
        }
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


