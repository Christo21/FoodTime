//
//  MyListViewController.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 04/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

class MyListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate{
    
    @IBOutlet weak var homeSearchBar: UISearchBar!
    @IBOutlet weak var homeTableView: UITableView!
    
    var homeItem:[Item] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! HomeTableViewCell
        
        cell.detailImage.image? = UIImage(named: homeItem[indexPath.row].getImage())!
        cell.expiredDateOfImage.text = String(describing: homeItem[indexPath.row].getExipredDate())
        cell.imageName.text = homeItem[indexPath.row].getName()
        cell.noteOfImage.text = homeItem[indexPath.row].getNote()
        
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
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (ac, view, success) in
            self.homeItem.remove(at: indexPath.row)
            self.homeTableView.reloadData()
            success(true)
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    func loadItems(){
        let Burger: Item = Item(idItem: "1", name: "Burger", type: "Food", quantity: 2, image: "burger", price: "20000", note: "This is your Burger", registDate: "2017/12/1", expiredDate: "2017/12/3")
        let Spaghetti: Item = Item(idItem: "2", name: "Spaghetti", type: "Food", quantity: 1, image: "spaghetti", price: "30000", note: "This is your Spaghetti", registDate: "2017/12/1", expiredDate: "2017/12/3")
        let Fish: Item = Item(idItem: "3", name: "Fish", type: "Food", quantity: 3, image: "fish", price: "40000", note: "This is your Fish", registDate: "2017/12/1", expiredDate: "2017/12/3")
        let Paprika: Item = Item(idItem: "4", name: "paprika", type: "Vegetable", quantity: 10, image: "paprika", price: "50000", note: "This is your paprika", registDate: "2017/12/1", expiredDate: "2017/12/3")
        let Risole: Item = Item(idItem: "5", name: "Risole", type: "Food", quantity: 5, image: "risole", price: "60000", note: "This is your Risole", registDate: "2017/12/1", expiredDate: "2017/12/3")
        
        var items: [Item] = []
        items.append(Burger)
        items.append(Spaghetti)
        items.append(Fish)
        items.append(Paprika)
        items.append(Risole)
        homeItem = items
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarItem()
        loadItems()
        homeTableView.reloadData()
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        
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
