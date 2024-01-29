//
//  DepartureViewController.swift
//  AirportInfoBoard
//
//  Created by Михаил Чертов on 22.01.2024.
//

import UIKit

class DepartureViewController: UIViewController {
    
    lazy var yandexApi = YandexApi()
    
    private var flights: [ThreadProtocol] = []
    
    private let yandexView = YandexView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FlightTableViewCell.self, forCellReuseIdentifier: FlightTableViewCell.reuseId)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Вылет"
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(yandexView)
        
        yandexApi.getFlightDeparture { [weak self] flight in
            self?.flights = flight
            self?.tableView.reloadData()
        }
        
        createConstrinatsForYandexView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func createConstrinatsForYandexView() {
        yandexView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yandexView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yandexView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            yandexView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            yandexView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }

}


extension DepartureViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightTableViewCell.reuseId, for: indexPath) as? FlightTableViewCell else { return UITableViewCell() }
        let flight = flights[indexPath.row]
        cell.configure(flightNumber: flight.thread.number, flightName: flight.thread.title, modelAirplane: flight.thread.vehicle, timeFlight: flight.departure)
        return cell
    }
    
    
}

extension DepartureViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}
