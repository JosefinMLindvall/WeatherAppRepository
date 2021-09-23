import UIKit

class WeatherViewController: UIViewController {
  
  // ATTRIBUTES
  private let viewModel = WeatherViewModel()
  
  
  // IBOUTLETS
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var currentIcon: UIImageView!
  @IBOutlet weak var currentSummaryLabel: UILabel!
  @IBOutlet weak var forecastSummary: UITextView!
  
  
  // OVERRIDDEN METHODS
  override func viewDidLoad() {
    
    viewModel.locationNameBox.bindListenerToValue (listener: { [weak self] (locationName) -> Void in
      self?.cityLabel.text = locationName
    })
    
    viewModel.dateBox.bindListenerToValue (listener: { [weak self] (date) -> Void in
      self?.dateLabel.text = date
    })
    
    viewModel.iconBox.bindListenerToValue (listener: { [weak self] image in
      self?.currentIcon.image = image
    })
        
    viewModel.summaryBox.bindListenerToValue (listener: { [weak self] summary in
      self?.currentSummaryLabel.text = summary
    })
        
    viewModel.forecastSummaryBox.bindListenerToValue (listener: { [weak self] forecast in
      self?.forecastSummary.text = forecast
    })
  }
}
