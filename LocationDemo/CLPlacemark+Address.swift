import CoreLocation

extension CLPlacemark {
    func formattedAddress() -> String {
        
        func line(_ text: String?) -> String{
            if let actualText = text {
                return actualText + "\n"
            }
            return ""
        }
        
        var address = line(self.name)
        address += line(self.subLocality) //e.g. small town
        address += line(self.locality) //e.g. bigger town
        address += line(self.subAdministrativeArea) //e.g. county
        address += line(self.postalCode)
        address += line(self.administrativeArea) //e.g. england
        address += line(self.country) //e.g. UK
        return address
    }
}
