//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManger = WeatherManger()
    let locationManger = CLLocationManager ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestLocation()
        
        weatherManger.delegate = self
        searchTextField.delegate = self
        
    }
    @IBAction func loctionPressed(_ sender: UIButton) {
        locationManger.requestLocation()

    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loction = locations.last{
            locationManger.stopUpdatingLocation()
            let lat =  loction.coordinate.latitude
            let lon = loction.coordinate.longitude
            weatherManger.fetchWeather(latitude: lat, longtitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print (textField.text!)
        print("button keyboard preed")
        return true
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != ""{
            return true
        }
        else{
            searchTextField.placeholder = "Try Something!"
            return false
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (searchTextField.text != nil)  {
            let cityName = searchTextField.text!
            weatherManger.fetchWeather(cityName: cityName)
            searchTextField.text = ""			
        }
    }
    
}

//MARK: - WeatherMangerDelegate
/*extension WeatherViewController: CLLocationManagerDelegate {
    //func didUpdateLoction
    
}   */

//MARK: - WeatherMangerDelegate

extension  WeatherViewController:WeatherMangerDelegate {
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(named: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}










