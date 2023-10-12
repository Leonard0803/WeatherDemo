//
//  SelectCityViewController.swift
//  Weather
//
//  Created by 邹贤琳 on 2023/10/12.
//

import UIKit

protocol SelectCityViewControllerDelegate: NSObject {
    func selectCityViewController(_ controller: SelectCityViewController, didSelect city: WeatherInfoViewController.AvailableCity)
}

class SelectCityViewController: UITableViewController {
    
    var selectedCity: WeatherInfoViewController.AvailableCity?
    var cities: [WeatherInfoViewController.AvailableCity] = []
    weak var delegate: SelectCityViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择城市"
        tableView.register(SettingsCell.self, forCellReuseIdentifier: String(describing: SettingsCell.self))
    }
    
    func update(selectedCity: WeatherInfoViewController.AvailableCity,
                cities: [WeatherInfoViewController.AvailableCity]) {
        self.selectedCity = selectedCity
        self.cities = cities
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsCell.self), for: indexPath) as! SettingsCell
        let city = cities[indexPath.row]
        cell.config(key: city.name, isSelected: city == selectedCity)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectCityViewController(self, didSelect: cities[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
