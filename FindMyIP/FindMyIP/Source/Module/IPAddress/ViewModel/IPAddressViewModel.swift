//
//  IPAddressViewModel.swift
//  FindMyIP
//
//  Created by Jayamurugan on 10/02/24.
//

import Foundation
import Alamofire
import Combine

public class IPAddressViewModel: ObservableObject {
  //MARK: Properties
  @Published public var ipAddress: String = ""
  @Published public var orgName: String = ""
  @Published public var isLoading: Bool = true
  @Published public var errorMessage: String = ""

  public var cancellable = Set<AnyCancellable>()
  private var networkManager: NetworkManagerDelegate

  //MARK: Initialize
  init(networkManager: NetworkManagerDelegate = IPNetworkManager()) {
    self.networkManager = networkManager
  }

  func fetchIPAddress() {
    self.errorMessage = ""
    self.networkManager.fetchIPAddress(url: "https://ipapi.co/json/",
                                       responseModel: IPAddressResponse.self)
    .receive(on: DispatchQueue.main)
    .sink { [weak self] completion in
      guard let self = self else { return }
      switch completion {
      case .finished:
        self.isLoading = false
      case .failure(let error):
        self.errorMessage = "Unknown error: \(error.localizedDescription)"
      }
    } receiveValue: { [weak self] response in
      guard let self = self else { return }
      self.ipAddress = response.ip ?? ""
      self.orgName = response.org ?? ""
    }
    .store(in: &cancellable)
  }

}
