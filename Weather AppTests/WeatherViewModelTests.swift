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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
