//
//  SettingsController.swift
//  ForecastLine
//
//  Created by alex on 19.07.2021.
//

import UIKit

final class SettingsController: BaseViewController {
    
    private var settingsTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let viewModel: SettingsViewModel
    private let cellManager: SettingsCellManager
    
    init(viewModel: SettingsViewModel, cellManager: SettingsCellManager) {
        self.viewModel = viewModel
        self.cellManager = cellManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.backgroundColor = .white
    }
}

extension SettingsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return viewModel.settingsSections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let settingsSection = viewModel.settingsSections[section]
        return cellManager.getViewForHeaderInSection(tableView, sectionDescription: settingsSection.description)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return cellManager.getHeightForHeaderInSection(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.getNumberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let sectionType = viewModel.getSectionType(indexPath: indexPath)
        
        return cellManager.buildCell(tableView: tableView, indexPath: indexPath, sectionType: sectionType)
    }
}

extension SettingsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let section = SettingsSection(rawValue: indexPath.section) else { return }
        
        switch section {
//        case .Appearance:
            //print let appearance = AppearanceOptions(rawValue: indexPath.row)
        case .Other:
            let other = OtherOptions(rawValue: indexPath.row)
            if other == OtherOptions.privacy {
                let privacyController = PrivacyCreator().getController()
                navigationController?.pushViewController(privacyController, animated: true)
            }
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension SettingsController {
    
    private func setupTableView() {
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.alwaysBounceVertical = false
        settingsTableView.tableFooterView = UIView()
        settingsTableView.register(cellType: SettingsTableViewCell.self)
        view.addSubview(settingsTableView)
        settingsTableView.frame = view.bounds
    }
}
