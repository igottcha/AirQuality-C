//
//  CountriesTableViewController.swift
//  AirQuality ObjC
//
//  Created by Chris Gottfredson on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CountriesTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    var countries: [String] = [] {
        didSet {
            updateTableViews()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        GTTCityAirQualityController.fetchSupportedCountries { (countries) in
            if let countries = countries {
                self.countries = countries
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let country = countries[indexPath.row]
        
        cell.textLabel?.text = country
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStateVC" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? StatesTableViewController else { return }
            let country = countries[indexPath.row]
            destinationVC.country = country
        }
    }
    
    //MARK: - Methods
    
    func updateTableViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
