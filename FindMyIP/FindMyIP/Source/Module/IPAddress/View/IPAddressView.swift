//
//  IPAddressView.swift
//  FindMyIP
//
//  Created by Jayamurugan on 10/02/24.
//

import SwiftUI

public struct IPAddressView: View {
  //MARK: Properties
  @StateObject var viewModel = IPAddressViewModel()

  //MARK: Initialize
  public init() {}

    public var body: some View {
      VStack {
        if self.viewModel.isLoading{
          LoadingIndicatorView(isLoading: self.viewModel.isLoading, error: self.viewModel.errorMessage) {
            self.getAPICall()
          }
        }else {
          Text(self.viewModel.orgName)
          Text(self.viewModel.ipAddress)
        }
      }.task {
        getAPICall()
      }
    }

  func getAPICall(){
    self.viewModel.fetchIPAddress()
  }
}

#Preview {
    IPAddressView()
}
