//
//  NetworkManager.swift
//  FindMyIP
//
//  Created by Jayamurugan on 10/02/24.
//

import Foundation
import Combine
import Alamofire


//MARK: NetworkManagerDelegate
public protocol NetworkManagerDelegate: AnyObject {
  func fetchIPAddress<T:Decodable>(url: String, responseModel: T.Type) -> AnyPublisher<T, Error>
}

public class IPNetworkManager: NetworkManagerDelegate {

  public init() {}


  public func fetchIPAddress<T>(url: String, responseModel: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
    return Future<T, Error> { promise in
      AF.request(url)
        .validate()
        .responseDecodable(of: T.self) { response in
          switch response.result {
          case .success(let decodedResponse):
            promise(.success(decodedResponse))
          case .failure(let error):
            promise(.failure(error))
          }
        }
    }
    .eraseToAnyPublisher()
  }


}
