//
//  ModelFlight.swift
//  AirportInfoBoard
//
//  Created by Михаил Чертов on 27.01.2024.
//


struct Schedule: Codable {
    let schedule: [Thread]
}


struct Thread: Codable {
    let thread: Flight
    let departure: String?
    let arrival: String?
}

struct Flight: Codable {
    let number: String
    let title: String
    let vehicle: String
}

