//
//  MockIPNetworkManager.swift
//  FindMyIPTests
//
//  Created by Jayamurugan on 10/02/24.
//

import Foundation
import Combine
@testable import FindMyIP

class MockIPNetworkManager: NetworkManagerDelegate {

  //MARK: Properties
  let failureCase: Bool

  //MARK: Initialize
  init(failureCase: Bool) {
    self.failureCase = failureCase
  }

  func fetchIPAddress<T>(url: String, responseModel: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
    return Future<T, Error> { promise in
      if self.failureCase{
        promise(.failure(NSError(domain: "MockError", code: 500, userInfo: nil)))
      }else {
        if let response = self.getMockData() as? T {
          promise(.success(response))
        }else{
          promise(.failure(NSError(domain: "MockResponse", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load mock data"])))
        }
      }
    }
    .eraseToAnyPublisher()
  }

  func getMockData() -> IPAddressResponse {
    IPAddressResponse(ip: "2406:7400:c6:87ae:ac53:1cee:ef1a:b33c",
                      network: "2406:7400:c0::/42",
                      version: "IPv6",
                      city: "Chennai",
                      region: "Tamil Nadu",
                      regionCode: "TN",
                      country: "IN",
                      countryName: "India",
                      countryCode: "IN",
                      countryCodeIso3: "IND",
                      countryCapital: "New Delhi",
                      countryTLD: ".in",
                      continentCode: "AS",
                      inEu: false,
                      postal: "600082",
                      latitude: 12.8996,
                      longitude: 80.2209,
                      timezone: "Asia/Kolkata",
                      utcOffset: "+0530",
                      countryCallingCode: "+91",
                      currency: "INR",
                      currencyName: "Rupee",
                      languages: "en-IN,hi,bn,te,mr,ta,ur,gu,kn,ml,or,pa,as,bh,sat,ks,ne,sd,kok,doi,mni,sit,sa,fr,lus,inc",
                      countryArea: 3287590.0,
                      countryPopulation: 1352617328,
                      asn: "AS24309",
                      org: "Atria Convergence Technologies Pvt. Ltd. Broadband Internet Service Provider INDIA")
  }

}
