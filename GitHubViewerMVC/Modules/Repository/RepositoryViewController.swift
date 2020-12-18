//
//  ViewController.swift
//  GitHubViewerMVC
//
//  Created by Andrei Dobysh on 27.11.20.
//

import UIKit

class RepositoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    private var repositories: [RepositoryModel] = []
    
    @IBAction func goAction(_ sender: Any) {
        RepositoryModel.load(user: textField?.text ?? "") { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case .complete(let value):
                self.repositories = value
                self.tableView.reloadData()
            case .error(let error):
                print("!!!", error)
                self.repositories = []
                self.tableView.reloadData()
            }
        }
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RepositoryViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryCell.self)) as? RepositoryCell,
              let item = repositories[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = item.name
        cell.descriptionLabel.text = item.createdAt
        return cell
    }
    
}
