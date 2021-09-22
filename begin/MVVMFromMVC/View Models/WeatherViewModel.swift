import Foundation
import UIKit.UIImage // Rule of thumb: never import "UIKit" as a whole in a view model, only import what is needed.

let LOADING_STRING = "Loading..."

// This class is made public to be open for testing
public class WeatherViewModel {
  
  private let geocoder = LocationGeocoder()
  static let defaultAddress = "McGaheysville, VA"
  
  let locationNameBox = Box(LOADING_STRING)
  
  init() {
    changeLocation(to: Self.defaultAddress)
  }

  private func fetchWeatherForLocation(_ location: Location) {
    WeatherbitService.weatherDataForLocation(
      latitude: location.latitude,
      longitude: location.longitude) { [weak self] (weatherData, error) in
        guard
          let self = self,
          let weatherData = weatherData
          else {
            return
          }
    }
  }
  
  func changeLocation(to newLocation: String) {
    locationNameBox.value = LOADING_STRING
    
    geocoder.convertStringToLocation(addressString: newLocation) { [weak self] locations in
      guard let self = self else { return }
      if let location = locations.first {
        self.locationNameBox.value = location.name // The listener defined in the view controller is triggered
        self.fetchWeatherForLocation(location)
        return
      }
    }
  }

  
  
  
}
