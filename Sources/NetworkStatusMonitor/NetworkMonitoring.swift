//
//  NetworkMonitoring.swift
//
//
//  Created by Marcel on 12.02.2024.
//

import SwiftUI

protocol NetworkMonitoring: ObservableObject {
    var isConnected: Bool { get }
    func startMonitoring()
    func stopMonitoring()
}
