//
//  BaseNavigationBar.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 06.07.2023.
//

import UIKit
import SnapKit
import CoreLocation

final class BaseNavigationBar: UIView {
    
    // MARK: - Private
    private let locationManager = CLLocationManager()
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM, yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    // MARK: - UI
    private let locationIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "locationIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .sfpdM18
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray3
        label.font = .sfpdR14
        return label
    }()
    
    // MARK: - Cosntructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup views
private extension BaseNavigationBar {
    func setup() {
        setupViews()
        setupLocationManager()
        updateDateLabel()
    }
    
    func setupViews() {
        addSubview(locationIconImageView)
        locationIconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(2)
        }
        
        addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(locationIconImageView.snp.trailing).offset(4)
            make.top.equalToSuperview()
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(locationLabel)
            make.top.equalTo(locationLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func updateDateLabel() {
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        dateLabel.text = formattedDate
    }
}

// MARK: - Delegate
extension BaseNavigationBar: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
                guard let self = self else { return }

                if let error = error {
                    print("Failed to get location: \(error.localizedDescription)")
                    return
                }

                if let placemark = placemarks?.first {
                    DispatchQueue.main.async {
                        self.locationLabel.text = placemark.locality
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}
