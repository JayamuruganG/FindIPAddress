//
//  LoadingIndicatorView.swift
//  FindMyIP
//
//  Created by Jayamurugan on 10/02/24.
//

import SwiftUI

struct LoadingIndicatorView: View {
  //MARK: Properties
  private var isLoading: Bool
  private var error: String?
  private var retry: (() -> Void)?

  init(isLoading: Bool, error: String?, retry: (() -> Void)?) {
    self.isLoading = isLoading
    self.error = error
    self.retry = retry
  }
    var body: some View {
      Group{
        if isLoading, let error = error, error.isEmpty {
          VStack(alignment: .center){
            ProgressView()
              .controlSize(.extraLarge)
              .progressViewStyle(CircularProgressViewStyle(tint: .gray))
          }
        }else if let error = error, !error.isEmpty {
          HStack{
            VStack(spacing:8){
              Text(error).padding(.all, 10)
              if self.retry != nil {
                Button(action: self.retry!, label: {
                  Text("Retry")
                    .font(.system(size: 16)).bold()
                })
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
              }
            }
          }
        }
      }
    }
}

#Preview {
  LoadingIndicatorView(isLoading: true, error: ""){
    print("Test")
  }
}
