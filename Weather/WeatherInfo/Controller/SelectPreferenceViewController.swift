//
//  SelectPreferenceViewController.swift
//  Weather
//
//  Created by 邹贤琳 on 2023/10/12.
//

import UIKit

protocol SelectPreferenceViewControllerDelegate: NSObject {
    func selectPreferenceViewController(_ controller: SelectPreferenceViewController, didUpdate preferences: [WeatherInfoViewController.WeatherDisplayPreferences])
}

class SelectPreferenceViewController: UITableViewController {
    
    var selectedPreferences: [WeatherInfoViewController.WeatherDisplayPreferences] = []
    var preferences: [WeatherInfoViewController.WeatherDisplayPreferences] = []
    weak var delegate: SelectPreferenceViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择偏好"
        tableView.register(SettingsCell.self, forCellReuseIdentifier: String(describing: SettingsCell.self))
    }
    
    func update(selectedPreferences: [WeatherInfoViewController.WeatherDisplayPreferences],
                preferences: [WeatherInfoViewController.WeatherDisplayPreferences]) {
        self.selectedPreferences = selectedPreferences
        self.preferences = preferences
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preferences.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsCell.self), for: indexPath) as! SettingsCell
        let preference = preferences[indexPath.row]
        let isSelected = selectedPreferences.contains(preference)
        cell.config(key: preference.name, isSelected: isSelected)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let preference = preferences[indexPath.row]
        if let index = selectedPreferences.firstIndex(of: preference) {
            selectedPreferences.remove(at: index)
            tableView.reloadRows(at: [indexPath], with: .fade)
        } else {
            selectedPreferences.append(preference)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        let sortedPreferences = selectedPreferences.sorted()
        self.delegate?.selectPreferenceViewController(self, didUpdate: sortedPreferences)
    }
}
