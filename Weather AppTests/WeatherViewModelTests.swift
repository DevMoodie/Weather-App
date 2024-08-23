//
//  WeatherViewModelTests.swift
//  Weather AppTests
//
//  Created by Moody on 2024-08-23.
//

import XCTest
import Combine
@testable import Weather_App

final class WeatherViewModelTests: XCTestCase {
    
    var viewModel: WeatherViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        viewModel = WeatherViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertEqual(viewModel.cityName, "")
        XCTAssertEqual(viewModel.temperature, "--")
        XCTAssertEqual(viewModel.condition, "--")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchWeatherSuccess() {
        // Set up a mock respoinse
        let mockWeather = WeatherModel(name: "Toronto", main: WeatherModel.Main(temp: 273.15 + 20), weather: [WeatherModel.Weather(description: "clear sky")])
        
        viewModel.fetchWeatherSuccess(weather: mockWeather)
        
        XCTAssertEqual(viewModel.temperature, "20°C")
        XCTAssertEqual(viewModel.condition, "Clear Sky")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchWeatherFailure() {
        viewModel.fetchWeatherFailure(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "City not found"]))

        XCTAssertEqual(viewModel.temperature, "--")
        XCTAssertEqual(viewModel.condition, "--")
        XCTAssertEqual(viewModel.errorMessage, "City not found")
    }

    func testFetchWeatherInvalidCityName() {
        viewModel.cityName = ""
        viewModel.fetchWeather()

        XCTAssertEqual(viewModel.temperature, "--")
        XCTAssertEqual(viewModel.condition, "--")
        XCTAssertEqual(viewModel.errorMessage, "Invalid City Name")
    }
}
