//
//  YnadexView.swift
//  AirportInfoBoard
//
//  Created by Михаил Чертов on 27.01.2024.
//

import UIKit

class YandexView: UIView {

    private let yandexText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Данные предоставлены сервисом\nЯндекс.Расписание"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let yandexURL: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "http://rasp.yandex.ru/"
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9976169467, green: 0.9954109788, blue: 0.2374812663, alpha: 1)
        addSubview(stackView)
        stackView.addArrangedSubview(yandexText)
        stackView.addArrangedSubview(yandexURL)
        constraintsConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraintsConfigure() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    

}
