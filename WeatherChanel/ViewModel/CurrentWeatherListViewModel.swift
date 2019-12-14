//
//  CurrentWeatherListViewModel.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


final class CurrentWeatherListViewModel: ObservableObject, UnidirectionalDataFlowType {
    typealias InputType = Input

    private var cancellables: [AnyCancellable] = []
    @Published var isErrorShown = false
    @Published var errorMessage = ""

    // MARK: - Dependencies
    private let responseSubject = PassthroughSubject<CurrentWeatherResponse, Never>()
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
    @Published private(set) var cities: [City] = []
    let errorTitle = "Error"
    let screenTitle = "Current Weather"


    // MARK: - Init
    init(apiService: APIServiceType = APIService()) {
        self.apiService = apiService

        bindInputs()
        bindOutputs()
    }

    // MARK: - Func
    private func bindInputs() {
        let request = CurrentWeatherRequest()
        let responsePublisher = onEventSubject
            .flatMap { [apiService] _ in
                apiService.response(from: request)
                    .catch { [weak self] error -> Empty<CurrentWeatherResponse, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                }
        }

        let responseStream = responsePublisher
            .share()
            .subscribe(responseSubject)

        cancellables += [
            responseStream,
        ]
    }

    private func bindOutputs() {
        let citiesStream = responseSubject
            .map {
                Logger.log(text: "Current weather call succed", level: .info)
                return $0.cities
        }
            .assign(to: \.cities, on: self)

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
            citiesStream,
            errorMessageStream,
            errorStream
        ]
    }
}
