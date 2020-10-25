//
//  Repository.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/18/20.
//

import Foundation
import Combine

class Repository<Element> {

    // MARK: - Properties
    private var cancellableBag = Set<AnyCancellable>()

    //Loading
    @Published private var isLoading: Bool = false
    var isLoadingPublisher: Published<Bool>.Publisher {
        $isLoading
    }

    //Error
    let error = PassthroughSubject<Error, Never>()

    //Has data
    @Published private var hasData: Bool = false
    var hasDataPublisher: Published<Bool>.Publisher {
        $hasData
    }

    //Data
    @Published private var data: [Element] = []
    var dataPublisher: Published<[Element]>.Publisher {
        $data
    }

    //Request
    private let request =
        PassthroughSubject<AnyPublisher<[Element], Error>, Never>()

    var refreshSource: AnyPublisher<[Element], Error> {
        fatalError("Subclass must provide the refresh source")
    }

    // MARK: - Initializers
    init() {
        configureHasDataUpdates()
        configureDataLoad()
    }

    // MARK: - Configuration
    private func configureHasDataUpdates() {
        $data
            .map({ $0.isEmpty })
            .assign(to: \.hasData, on: self)
            .store(in: &cancellableBag)
    }

    private func configureDataLoad() {
        print("Repository will configureDataLoad")
        request
            .sink(receiveValue: { [weak self] (source) in
                print("Repository request.sink source: \(source)")
                self?.isLoading = true
                _ = source.sink { (completion) in
                    self?.isLoading = false
                    print("Repository source completion \(completion)")
                    //TODO: check error
                } receiveValue: { (value) in
                    print("Repository source receiveValue \(value.count)")
                    self?.data = value
                }
            })
            .store(in: &cancellableBag)
    }

    func fetchData() {
        print("Repository will fetchData")
        request.send(refreshSource)
    }
}
