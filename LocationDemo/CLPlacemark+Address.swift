import CoreLocation

extension CLPlacemark {
    func formattedAddress() -> String {
        
        func line(_ text: String?) -> String{
            return text != nil ? "\(text!)\n" : ""
        }
        
        let addressElements = [name,subLocality,locality,subAdministrativeArea,postalCode,administrativeArea,country]
        var address = ""
        for element in addressElements {
            address += line(element)
        }
        return address
    }
}
