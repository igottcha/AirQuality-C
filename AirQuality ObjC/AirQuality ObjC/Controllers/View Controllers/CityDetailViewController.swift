//
//  CityDetailViewController.swift
//  AirQuality ObjC
//
//  Created by Chris Gottfredson on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    //MARK: - Properties
    
    var country: String?
    var state: String?
    var city: String?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = city, let state = state, let country = country else { return }
        
        GTTCityAirQualityController.fetchDataforCity(city, state: state, country: country) { (cityData) in
                self.updateViews(with: cityData)
        }
    }
    
    //MARK: - Methods
    
    func updateViews(with cityData: GTTCityAirQuality) {
        DispatchQueue.main.async {
            self.countryLabel.text = cityData.country
            self.stateLabel.text = cityData.state
            self.cityLabel.text = cityData.city
            self.aqiLabel.text = "\(cityData.pollution.airQualityIndex)"
            self.temperatureLabel.text = "\(cityData.weather.temperature)℃"
            self.humidityLabel.text = "\(cityData.weather.humidity)%"
            self.windSpeedLabel.text = "\(cityData.weather.windSpeed)m/s"
        }
    }
    
}
