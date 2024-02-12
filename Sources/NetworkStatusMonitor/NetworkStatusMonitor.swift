//
//  NetworkStatusMonitor.swift
//
//
//  Created by Marcel on 12.02.2024.
//

import Network
import Foundation

public class NetworkStatusMonitor: NetworkMonitoring {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "NetworkMonitorQueue")
    @Published public var isConnected: Bool = false

    public init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        networkMonitor.start(queue: workerQueue)
    }

    public func startMonitoring() {
        networkMonitor.start(queue: workerQueue)
    }

    public func stopMonitoring() {
        networkMonitor.cancel()
    }
}
