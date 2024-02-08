//
//  CountryDetailsVC.swift
//  CountriesApp
//
//  Created by Guy Twig on 08/02/2024.
//

import UIKit

class CountryDetailsVC: UIViewController {

    private var country: CountryData?
    private var vm: CountryDetailsVM?
    
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var flagLbl: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var subregionLbl: UILabel!
    @IBOutlet weak var regionView: UIView!
    @IBOutlet weak var subRegionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let country {
            vm = CountryDetailsVM(country: country)
        }
        setupContent()
    }
    
    init(country: CountryData?) {
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }
            
            if let country = self.country {
                self.countryNameLbl.text = country.name?.common ?? "No Country Name Found"
                self.flagLbl.text = country.flag ?? "🏴‍☠️"
                self.regionLbl.text = country.region
                self.subregionLbl.text = country.subregion
                if (country.region?.isEmpty ?? true) {
                    self.regionView.isHidden = true
                }
                if (country.subregion?.isEmpty ?? true) {
                    self.subRegionView.isHidden = true
                }
            } else {
                self.showAlert(title: "Could not load Country, please try again", message: "")
            }
        }
    }
}
