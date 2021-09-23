import Foundation
import UIKit.UIImage // Rule of thumb: never import "UIKit" as a whole in a view model, only import what is needed.

let LOADING_STRING = "Loading..."
let LOCATION_ERROR_STRING = "Could not find location"
let WEATHER_ERROR_STRING = "Error retreiving weather data for selected location"
let TEMPERATURE_ERROR_STRING = "Error when retrieving temperature"


// This class is made public to be open for testing
public class WeatherViewModel {
  
  private let geocoder = LocationGeocoder()
  static let defaultAddress = "Huskvarna, Jönköping"
  
  let locationNameBox = Box(value: LOADING_STRING)
  let dateBox = Box(value: " ")
  let iconBox: Box<UIImage?> = Box(value: nil)  //no image initially
  let summaryBox = Box(value: " ")
  let forecastSummaryBox = Box(value: " ")

  
  init() {
    updateLocation(to: Self.defaultAddress)
  }
  
  // This is a custom definition of the built in "Dateformatter" defined with scope syntax.
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d"
    return dateFormatter
  }()
  
  // This is a custom definition of the built in "NumberFormatter" defined with scope syntax.
  private let tempFormatter: NumberFormatter = {
    let tempFormatter = NumberFormatter()
    tempFormatter.numberStyle = .none
    return tempFormatter
  }()
  

  private func fetchWeatherForLocation(_ location: Location) {
    WeatherbitService.weatherDataForLocation(latitude: location.latitude, longitude: location.longitude) { [weak self] (weatherData, error) in
        guard
          let self = self,
          let weatherData = weatherData
          else {
            self?.updateBoxedValuesOnError(errorMessage: WEATHER_ERROR_STRING)
            return
          }
      self.updateBoxedValues(with: weatherData)
    }
  }
  
  func updateLocation(to newLocation: String) -> Void {
    
    locationNameBox.value = LOADING_STRING
    geocoder.convertStringToLocation(addressString: newLocation) { [weak self] locations in
      guard let self = self else { return }
      if let location = locations.first {
        self.locationNameBox.value = location.name // The listener defined in the view controller is triggered
        self.fetchWeatherForLocation(location)
        return
      }
      else{
        self.updateBoxedValuesOnError(errorMessage: LOCATION_ERROR_STRING)
      }
    }
  }
  
  private func updateBoxedValues(with weatherData: WeatherbitData) -> Void {
    self.dateBox.value = self.dateFormatter.string(from: weatherData.date)
    self.iconBox.value = UIImage(named: weatherData.iconName)
    
    let temp = self.convertFarenheitStringToCelciusString(tempStringInFarenheit: self.tempFormatter.string(from: weatherData.currentTemp as NSNumber)!)
    
    self.summaryBox.value = "\(weatherData.description) , \(temp) C°"
    
    self.forecastSummaryBox.value = "\nSummary: \(weatherData.description)"
  }
  
  private func updateBoxedValuesOnError(errorMessage: String) -> Void {
    self.locationNameBox.value = errorMessage
    self.dateBox.value = ""
    self.iconBox.value = nil
    self.summaryBox.value = ""
    self.forecastSummaryBox.value = ""
  }
  
  private func convertFarenheitStringToCelciusString(tempStringInFarenheit: String) -> String {
    if let tempInFarenheit = Double(tempStringInFarenheit) {
      let tempInCelciusAsDouble =  (tempInFarenheit - 32) / 1.8000
      return String(Int(tempInCelciusAsDouble))
    }
    else{
      return TEMPERATURE_ERROR_STRING
    }
  }
}
