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
    @Published private(set) var isConnected: Bool = false

    public init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
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
