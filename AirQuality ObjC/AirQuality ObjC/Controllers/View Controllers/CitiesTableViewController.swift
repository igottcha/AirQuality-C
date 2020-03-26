//
//  CitiesTableViewController.swift
//  AirQuality ObjC
//
//  Created by Chris Gottfredson on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    var country: String?
    var state: String?
    var cities: [String] = [] {
        didSet {
            updateTableViews()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        guard let country = country, let state = state else { return }
        GTTCityAirQualityController.fetchSupportedCities(inState: state, country: country) { (cities) in
            self.cities = cities
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCityDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? CityDetailViewController else { return }
            let city = cities[indexPath.row]
            destinationVC.city = city
            destinationVC.state = state
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
