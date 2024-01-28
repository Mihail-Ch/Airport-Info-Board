//
//  YandexApi.swift
//  AirportInfoBoard
//
//  Created by Михаил Чертов on 27.01.2024.
//

import Foundation


final class YandexApi {
    
    
    enum ApiEvent {
        case departure
        case arrival
        
        var event: String {
            switch self {
            case .arrival:
                return "arrival"
            case .departure:
                return "departure"
            }
        }
    }
    
    private func currentTime() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
    
    
    private func request(query: ApiEvent, complition: @escaping (Data?) -> Void) {
        let session = URLSession.shared
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.rasp.yandex.net"
        urlConstructor.path = "/v3.0/schedule/"
        urlConstructor.queryItems = [
            URLQueryItem(name: "apikey", value: "4b61d225-ad5b-48f8-a743-6d844a253a5c"),
            URLQueryItem(name: "station", value: "s9600213"),
            URLQueryItem(name: "transport_types", value: "plane"),
            URLQueryItem(name: "event", value: "\(query.event)"),
            URLQueryItem(name: "date", value: "\(currentTime())")
        ]
        
        guard let url = urlConstructor.url else { return }
        print("URL: 👉 \n\(url)")
        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                complition(data)
            }
        }
        task.resume()
    }
    
    func getFlightArrival(complition: @escaping ([Thread]) -> Void) {
        request(query: .arrival) { data in
            guard let data = data else { return }
            do {
                let schedule = try JSONDecoder().decode(Schedule.self, from: data)
                complition(schedule.schedule)
            } catch {
                print(error)
            }
        }
    }
    
    func getFlightDeparture(complition: @escaping ([Thread]) -> Void) {
        request(query: .departure) { data in
            guard let data = data else { return }
            do {
                let schedule = try JSONDecoder().decode(Schedule.self, from: data)
                complition(schedule.schedule)
            } catch {
                print(error)
            }
        }
    }
}

