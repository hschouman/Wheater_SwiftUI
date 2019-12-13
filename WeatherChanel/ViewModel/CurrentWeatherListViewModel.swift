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

    // MARK: - Intput
    enum Input {
        case onAppear
    }
    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        }
    }
    private let onAppearSubject = PassthroughSubject<Void, Never>()

    // MARK: - Output
    @Published private(set) var cities: [City] = []


    private let apiService: APIServiceType

    // MARK: - Init
    init(apiService: APIServiceType = APIService()) {
        self.apiService = apiService

        bindInputs()
        bindOutputs()
    }

    // MARK: - Func
    private func bindInputs() {
        let request = CurrentWeatherRequest()
        let responsePublisher = onAppearSubject
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
            responseStream
        ]
    }

    private func bindOutputs() {
        let citiesStream = responseSubject
            .map { $0.cities }
            .assign(to: \.cities, on: self)

        let errorMessageStream = errorSubject
            .map { error -> String in
                switch error {
                case .callFailed: return "network error"
                case .parseError: return "parse error"
                default:
                    return "api failed"
                }
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
