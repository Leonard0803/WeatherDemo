//
//  SettingsCell.swift
//  Weather
//
//  Created by 邹贤琳 on 2023/10/12.
//

import UIKit

class SettingsCell: UITableViewCell {

    lazy var selectedImageView: UIImageView = {
        var imageView = UIImageView.init(image: UIImage.init(named: "selected"))
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(selectedImageView)
    }

    func config(key: String, isSelected: Bool) {
        textLabel?.text = key
        selectedImageView.isHidden = !isSelected
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
