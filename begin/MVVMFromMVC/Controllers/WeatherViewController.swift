import UIKit

class WeatherViewController: UIViewController {
  
  // ATTRIBUTES
  private let viewModel = WeatherViewModel()
  
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d"
    return dateFormatter
  }()
  
  private let tempFormatter: NumberFormatter = {
    let tempFormatter = NumberFormatter()
    tempFormatter.numberStyle = .none
    return tempFormatter
  }()
  
  
  // IBOUTLETS
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var currentIcon: UIImageView!
  @IBOutlet weak var currentSummaryLabel: UILabel!
  @IBOutlet weak var forecastSummary: UITextView!
  
  
  // OVERRIDDEN METHODS
  override func viewDidLoad() {
    viewModel.locationName.bind { [weak self] locationName in
      
      self?.cityLabel.text = locationName // This code binds cityLabel.text to viewModel.locationName.
    }
  }

  // GENERAL METHODS
  
}
