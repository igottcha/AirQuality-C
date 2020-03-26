//
//  StatesTableViewController.swift
//  AirQuality ObjC
//
//  Created by Chris Gottfredson on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class StatesTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    var country: String?
    var states: [String?] = [] {
        didSet {
            updateTableView()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        guard let country = country else { return }
        GTTCityAirQualityController.fetchSupportedStates(inCountry: country) { (states) in
            self.states = states
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StateCell", for: indexPath)
        let state = states[indexPath.row]
        cell.textLabel?.text = state
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCityVC" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? CitiesTableViewController else { return }
            let state = states[indexPath.row]
            destinationVC.state = state
            destinationVC.country = country
        }
    }
    
    //MARK: - Methods
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
