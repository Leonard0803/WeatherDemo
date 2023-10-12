//
//  WeatherInfoViewController.swift
//  Weather
//
//  Created by 邹贤琳 on 2023/10/11.
//

import UIKit
import HandyJSON
import Moya
import Alamofire

class WeatherInfoViewController: UIViewController {
    
    enum WeatherDisplayPreferences: Int, Codable, CaseIterable, Comparable {
        case date = 1
        case temperature = 2
        case weather = 3
        case wind = 4
        case power = 5
        
        var name: String {
            switch self {
            case .date:
                return "日期"
            case .temperature:
                return "温度"
            case .wind:
                return "风向"
            case .power:
                return "风力"
            case .weather:
                return "气象"
            }
        }
        
        static func < (lhs: WeatherDisplayPreferences, rhs: WeatherDisplayPreferences) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }
    
    enum AvailableCity: String, CaseIterable {
        case beijing = "110000"
        case shenyang = "210100"
        case shanghai = "310000"
        case guangzhou = "440100"
        case suzhou = "320500"
        case shenzhen = "440300"
        
        var name: String {
            switch self {
            case .beijing:
                return "北京市"
            case .shenyang:
                return "沈阳市"
            case .shanghai:
                return "上海市"
            case .suzhou:
                return "苏州市"
            case .shenzhen:
                return "深圳市"
            case .guangzhou:
                return "广州市"
            }
        }
    }
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @PersistentCenter(key: .weatherDisplayPreferences, defaultValue: [.date, .temperature])
    var userPreference: [WeatherDisplayPreferences] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var currentForecast: Forecast?
    var currentCity: AvailableCity = .beijing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        refresh(cityCode: currentCity.rawValue)
    }
}

// MARK: - PrivateFunction
extension WeatherInfoViewController {
    
    private func configUI() {
        tableView.register(WeatherInfoTableViewCell.self, forCellReuseIdentifier: String(describing: WeatherInfoTableViewCell.self))
    }
    
    private func refresh(cityCode: String) {
        WeatherInfoApi.getWeatherInfo(city: cityCode).done { [weak self] response in
            guard let self = self else { return }
            self.currentForecast = response.forecasts.first
            self.currentCity = AvailableCity.init(rawValue: cityCode) ?? .beijing
            self.cityLabel.text = response.forecasts.first?.city
            self.tableView.reloadData()
        }.catch { error in
            print(error)
        }
    }
}

// MARK: - UserInteraction
extension WeatherInfoViewController {
    
    @IBAction func selectCity(_ sender: UIBarButtonItem) {
        let controller = SelectCityViewController.init(style: .plain)
        controller.delegate = self
        controller.update(selectedCity: currentCity, cities: AvailableCity.allCases)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func selectPreference(_ sender: UIBarButtonItem) {
        let controller = SelectPreferenceViewController.init(style: .plain)
        controller.delegate = self
        controller.update(selectedPreferences: userPreference, preferences: WeatherDisplayPreferences.allCases)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - SelectCityViewControllerDelegate
extension WeatherInfoViewController: SelectCityViewControllerDelegate {
    func selectCityViewController(_ controller: SelectCityViewController, didSelect city: AvailableCity) {
        self.currentCity = city
        self.refresh(cityCode: city.rawValue)
    }
}

// MARK: - SelectPreferenceViewControllerDelegate
extension WeatherInfoViewController: SelectPreferenceViewControllerDelegate {
    func selectPreferenceViewController(_ controller: SelectPreferenceViewController, didUpdate preferences: [WeatherDisplayPreferences]) {
        userPreference = preferences
    }
}

// MARK: - UITableViewDataSource
extension WeatherInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherInfoTableViewCell.self), for: indexPath) as? WeatherInfoTableViewCell else {
            return UITableViewCell()
        }
        if let model = currentForecast?.casts[safe: 1] {
            switch userPreference[indexPath.row] {
            case .temperature:
                cell.contentLabel.text = "白天温度: \(model.daytemp)℃   晚上温度\(model.nighttemp)℃"
            case .date:
                cell.contentLabel.text = "日期: \(model.date)   \(model.week.name)"
            case .wind:
                cell.contentLabel.text = "白天风向: \(model.daywind)   晚上风向: \(model.nightwind)"
            case .power:
                cell.contentLabel.text = "白天风力: \(model.daypower)级   晚上风力: \(model.nightpower)级"
            case .weather:
                cell.contentLabel.text = "白天气象: \(model.dayweather)   晚上气象: \(model.nightweather)"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPreference.count
    }
}
