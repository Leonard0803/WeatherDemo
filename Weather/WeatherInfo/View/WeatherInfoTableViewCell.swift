//
//  WeatherInfoTableViewCell.swift
//  Weather
//
//  Created by 邹贤琳 on 2023/10/12.
//

import UIKit

class WeatherInfoTableViewCell: UITableViewCell {

    lazy var contentLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentLabel)
        let topConstraint = contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        let bottomConstraint = contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        let leadingConstraint = contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        let trailingConstraint = contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
