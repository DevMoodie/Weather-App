//
//  WeatherView.swift
//  Weather App
//
//  Created by Moody on 2024-08-23.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter city name", text: $viewModel.cityName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    viewModel.fetchWeather()
                }) {
                    Text("Get Weather")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Text(viewModel.temperature)
                    .font(.largeTitle)

                Text(viewModel.condition)
                    .font(.title)

                Spacer()
            }
            .navigationTitle("Weather App")
            .padding()
        }
    }
}

#Preview {
    WeatherView()
}
