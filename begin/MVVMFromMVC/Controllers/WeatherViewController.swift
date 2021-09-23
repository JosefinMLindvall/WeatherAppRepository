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
  
    @IBAction func showLocationPrompt(_ sender: UIButton) {
      
      let alert = UIAlertController(
        title: "Choose location",
        message: nil,
        preferredStyle: .alert
      )
      alert.addTextField()
      
      let submitAction = UIAlertAction(title: "View Weather", style: .default) { [unowned alert, weak self] _ in
          guard let newLocation = alert.textFields?.first?.text
          else { return }
          self?.viewModel.updateLocation(to: newLocation)
      }
      
      alert.addAction(submitAction)
      present(alert, animated: true)
    }
    
  // OVERRIDDEN METHODS
  override func viewDidLoad() {
    
    viewModel.locationNameBox.bindListenerToValue (listener: { [weak self] (locationName) -> Void in
      self?.cityLabel.text = locationName
    })
    
    viewModel.dateBox.bindListenerToValue (listener: { [weak self] (date) -> Void in
      self?.dateLabel.text = date
    })
    
    viewModel.iconBox.bindListenerToValue (listener: { [weak self] (image) -> Void in
      self?.currentIcon.image = image
    })
        
    viewModel.summaryBox.bindListenerToValue (listener: { [weak self] (summary) -> Void in
      self?.currentSummaryLabel.text = summary
    })
        
    viewModel.forecastSummaryBox.bindListenerToValue (listener: { [weak self] (forecast) -> Void in
      self?.forecastSummary.text = forecast
    })
  }
}
