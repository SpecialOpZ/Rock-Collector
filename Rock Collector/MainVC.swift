//
//  ViewController.swift
//  Rock Collector
//
//  Created by Anthony on 3/16/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var rocks: [Rock] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            rocks = try context.fetch(Rock.fetchRequest())
            print(rocks)
        } catch {
            print("Unable to fetch results")
        }
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! RockVC
        nextVC.rock = sender as? Rock
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRock = rocks[indexPath.row]
        performSegue(withIdentifier: "rockSegue", sender: selectedRock)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RockCell
        let currentRock = rocks[indexPath.row]
        cell.updateCell(name: currentRock.title!, image:UIImage(data: currentRock.image! as Data)!)
        return cell
    }
}
