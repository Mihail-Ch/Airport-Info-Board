//
//  FlightTableViewCell.swift
//  AirportInfoBoard
//
//  Created by Михаил Чертов on 22.01.2024.
//

import UIKit

class FlightTableViewCell: UITableViewCell {

    static let reuseId = "flightTableViewCell"
    
    private let stackViewVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        return stackView
    }()
    
    private let numberFlight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGreen
        return label
    }()
    
    private let nameFlight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let modelPlain: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemRed
        return label
    }()
    
    private let timeFlight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        createUI()
    }
    
    private func currentTime(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "HH:mm"
            let timeString = dateFormatter.string(from: date)
            return timeString
        } else {
            return "Error: Дата пришла ПоЛоМоНоЙ 🤪"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        contentView.addSubview(stackViewVertical)
        contentView.addSubview(timeFlight)
        
        stackViewVertical.addArrangedSubview(numberFlight)
        stackViewVertical.addArrangedSubview(nameFlight)
        stackViewVertical.addArrangedSubview(modelPlain)

        createConstraints()
    }
    
    private func createConstraints() {
        let widthStack = self.contentView.bounds.height / 3
        
        NSLayoutConstraint.activate([
            stackViewVertical.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackViewVertical.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stackViewVertical.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackViewVertical.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            stackViewVertical.widthAnchor.constraint(equalToConstant: (contentView.bounds.width - widthStack) - 25),
            
            timeFlight.leadingAnchor.constraint(equalTo: stackViewVertical.trailingAnchor),
            timeFlight.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            timeFlight.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            timeFlight.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
    
    func configure(flightNumber: String?, flightName: String?, modelAirplane: String?, timeFlight: String?) {
        numberFlight.text = flightNumber ?? ""
        nameFlight.text = flightName ?? ""
        modelPlain.text = modelAirplane ?? ""
        if let timeFlight = timeFlight {
           let currentTime = currentTime(dateString: timeFlight)
            self.timeFlight.text = currentTime
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        numberFlight.text = nil
        nameFlight.text = nil
        modelPlain.text = nil
        timeFlight.text = nil
    }
}
