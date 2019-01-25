import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager!
    
    @IBAction func getAddressTapped(_ sender: Any) {
        reverseGeocode()
    }
    @IBOutlet weak var addressTextView: UITextView!
    var lastKnownLocation : CLLocation?
    
    @IBOutlet weak var chesterDistanceLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    
    @IBOutlet weak var directionView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    
    var heading = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLocationManager()
        
        //start updating location
        locationManager.startUpdatingLocation()
        
        //start updating heading
        locationManager.stopUpdatingHeading()
    }
    
    func configureLocationManager(){
    //create a location manager instance
    locationManager = CLLocationManager()
    
    //ask for user permission if neccessary
    if CLLocationManager.authorizationStatus() == .notDetermined {
    locationManager.requestWhenInUseAuthorization()
    }
    
    //ensure that the location manager's delegate is the view controller
    //(we also declare that this class implements CLLocationManagerDelegate)
    locationManager.delegate = self
    
    //set accuracy
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
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
        
        headingLabel.text = "\(newHeading.trueHeading)"
        let difference = newHeading.trueHeading - heading
        heading = newHeading.trueHeading
        directionView.rotate(angle: CGFloat(difference))
        
    }
    
    func reverseGeocode(){
        
        if let location = lastKnownLocation {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let places = placemarks {
                    if let closest = places.first {
                        self.addressTextView.text = closest.formattedAddress()
                    }
                }
            }
        }
    }
    
}



