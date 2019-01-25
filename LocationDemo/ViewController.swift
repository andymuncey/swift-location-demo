import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager!
    var lastKnownLocation : CLLocation?
    var heading = 0.0
    
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var chesterDistanceLabel: UILabel!
    @IBOutlet weak var addressTextView: UITextView!
   
    @IBOutlet weak var directionView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLocationManager()
        
        //start updating location
        locationManager.startUpdatingLocation()
        
        //start updating heading
        locationManager.startUpdatingHeading()
    }
    
    func configureLocationManager(){
        //create a location manager instance
        locationManager = CLLocationManager()
        
        //ask for user permission if neccessary
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        //ensure that the location manager's delegate is this view controller
        //(we also declare that this class implements CLLocationManagerDelegate)
        locationManager.delegate = self
        
        //set accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    @IBAction func getAddressTapped(_ sender: Any) {
        reverseGeocode()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //get the most recent location
        let lastLocation = locations.last!
        
        lastKnownLocation = lastLocation
        
        latLabel.text = "\(lastLocation.coordinate.latitude)"
        longLabel.text = "\(lastLocation.coordinate.longitude)"
        
        //create a location object with the coordinates for Chester
        let chester = CLLocation(latitude: 53.191824, longitude: -2.891015)
        
        //calculate the distance from Chester
        let distanceInMetres = lastLocation.distance(from: chester)
        let distanceInMiles = distanceInMetres / 1609.34
        
        chesterDistanceLabel.text = String(format: "%.1f miles away", distanceInMiles)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        headingLabel.text = String(format: "%.0f°", newHeading.trueHeading)
        directionView.rotate(degrees: CGFloat(-newHeading.trueHeading))
    }
    
    func reverseGeocode(){
        if let location = lastKnownLocation {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let closestPlace = placemarks?.first {
                    self.addressTextView.text = closestPlace.formattedAddress()
                }
            }
        }
    }
}



