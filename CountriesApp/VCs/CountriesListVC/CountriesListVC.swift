//
//  CountriesListVC.swift
//  CountriesApp
//
//  Created by Guy Twig on 08/02/2024.
//

import UIKit

class CountriesListVC: UIViewController {

    var vm: CountriesListVM?
    var countryList: [CountryData] = []
    var notFilteredCountryList: [CountryData] = []
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
        }
    }
    @IBOutlet weak var tblCountries: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl(to: tblCountries, action: #selector(refreshData))
        hideKeyboardWhenTappedAround(cancelTouches: false)
        vm = CountriesListVM()
        vm?.delegate = self
        setupTableView()
    }
    
    private func setupTableView() {
        tblCountries.delegate = self
        tblCountries.dataSource = self
        tblCountries.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "CountryCell")
    }
    
    private func filterCountries(with searchText: String) -> [CountryData] {
        let filteredList = notFilteredCountryList.filter { country in
            return country.name?.common?.lowercased().contains(searchText.lowercased()) ?? false
        }
        return filteredList
    }
    
    private func resetCountriesList() -> [CountryData] {
        return notFilteredCountryList
    }
    
    @objc private func refreshData() {
        vm?.fetchCountries()
    }
}

extension CountriesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        cell.setupCellContent(country: countryList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = CountryDetailsVC(country: countryList[indexPath.row])
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}

extension CountriesListVC: CountriesVMDelegate {
    func countriesFetched(countries: [CountryData]?, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }
            
            if let error {
                self.showAlert(title: "Something went wrong, please try again", message: error.localizedDescription)
            } else if let countries {
                self.countryList.removeAll()
                self.notFilteredCountryList.removeAll()
                self.countryList = countries
                self.notFilteredCountryList = countries
                self.tblCountries.reloadData()
                self.endRefreshing(scrollView: self.tblCountries)
            }
        }
    }
}

extension CountriesListVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let searchText = textField.text, !searchText.isEmpty {
            countryList = filterCountries(with: searchText)
        } else {
            countryList = resetCountriesList()
        }
        tblCountries.reloadData()
    }
}
