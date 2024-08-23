//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Moody on 2024-08-23.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var temperature: String = "--"
    @Published var condition: String = "--"
    @Published var errorMessage: String?
    
    private let apiKey = "YOUR_API_KEY_HERE"
    private var cancellables = Set<AnyCancellable>()
    
    func fetchWeather() {
        guard !cityName.isEmpty else {
            self.errorMessage = "Invalid City Name"
            return
        }
        
        let city = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? cityName
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.fetchWeatherFailure(error: error)
                case .finished:
                    break
                }
            } receiveValue: { weather in
                self.fetchWeatherSuccess(weather: weather)
            }
            .store(in: &cancellables)
    }
    
    func fetchWeatherSuccess(weather: WeatherModel) {
        self.temperature = weather.temperature
        self.condition = weather.condition
        self.errorMessage = nil
    }
    
    func fetchWeatherFailure(error: Error) {
        self.temperature = "--"
        self.condition = "--"
        self.errorMessage = error.localizedDescription
    }
}
