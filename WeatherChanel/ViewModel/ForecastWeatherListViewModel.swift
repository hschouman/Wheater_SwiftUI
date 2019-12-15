//
//  ForecastWeatherViewModel.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class ForecastWeatherListViewModel: ObservableObject, UnidirectionalDataFlowType {

    typealias InputType = Input

    private var cancellables: [AnyCancellable] = []
    @Published var isErrorShown = false
    @Published var errorMessage = ""

    // MARK: - Dependencies
    private let responseSubject = PassthroughSubject<ForecastWeatherResponse, Never>()
    private let errorSubject = PassthroughSubject<ServiceError, Never>()
    private let apiService: APIServiceType

    // MARK: - Intput
    enum Input {
        case onAppear
        case onRefresh
    }
    func apply(_ input: Input, completion: () -> ()) {
        switch input {
        case .onAppear: onEventSubject.send(completion())
        case .onRefresh: onEventSubject.send(completion())
        }
    }
    private let onEventSubject = PassthroughSubject<Void, Never>()

    // MARK: - Output
    @Published private(set) var city: City
    @Published private(set) var days: [Day] = []
    let errorTitle = "Error"

    // MARK: - Init
    init(city: City, apiService: APIServiceType = APIService()) {
        self.city = city
        self.apiService = apiService

        bindInputs()
        bindOutputs()
    }

    // MARK: - Func
    private func bindInputs() {
        let request = ForecastWeatherRequest(cityId: city.id)
        let responsePublisher = onEventSubject
            .flatMap { [apiService] _ in
                apiService.response(from: request)
                    .catch { [weak self] error -> Empty<ForecastWeatherResponse, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                }
        }

        let responseStream = responsePublisher
            .share()
            .subscribe(responseSubject)

        cancellables += [
            responseStream
        ]
    }

    private func bindOutputs() {
        let hoursStream = responseSubject
            .map {
                Logger.log(text: "Forecast weather call succed", level: .info)
                return self.computeDays(from: $0.hours)
        }
            .assign(to: \.days, on: self)

        let errorMessageStream = errorSubject
            .map { error -> String in

                Logger.log(text: error.description, level: .error)
                return String(error.description)
            }
            .assign(to: \.errorMessage, on: self)

        let errorStream = errorSubject
            .map { _ in true }
            .assign(to: \.isErrorShown, on: self)

        cancellables += [
            hoursStream,
            errorMessageStream,
            errorStream
        ]
    }

    private func computeDays(from hours: [Hour]) -> [Day] {
        var days = [Day]()
        hours.forEach { (hour) in
            if !days.contains(where: { Calendar.current.isDate($0.date, inSameDayAs: hour.date) }) {
                let day = Day(date: hour.date, hours: [hour])
                days.append(day)
            } else {
                guard let dayIndex = days.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: hour.date) }) else {
                    return
                }
                days[dayIndex].hours.append(hour)
            }
        }
        return sort(days: days)
    }

    private func sort(days: [Day]) -> [Day] {

        let presortedDays = days.sorted(by: { $0.date < $1.date })

        var sortedDays = [Day]()
        presortedDays.forEach { (day) in
            let sortedHours = day.hours.sorted(by: { $0.date < $1.date } )
            let sortedDay = Day(date: day.date, hours: sortedHours)
            sortedDays.append(sortedDay)
        }
        return sortedDays
    }
}
