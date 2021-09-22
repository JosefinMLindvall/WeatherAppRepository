import Foundation
import UIKit.UIImage // Rule of thumb: never import "UIKit" as a whole in a view model, only import what is needed.

// This class is made public to be open for testing
public class WeatherViewModel {
  
  private let geocoder = LocationGeocoder()
  static let defaultAddress = "McGaheysville, VA"
  let locationName = Box("Loading...")

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
    locationName.value = "Loading..."
    geocoder.geocode(addressString: newLocation) { [weak self] locations in
      guard let self = self else { return }
      if let location = locations.first {
        self.locationName.value = location.name
        self.fetchWeatherForLocation(location)
        return
      }
    }
  }

  
  
  
}
