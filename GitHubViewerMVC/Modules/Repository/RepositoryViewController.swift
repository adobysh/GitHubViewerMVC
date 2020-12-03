//
//  ViewController.swift
//  GitHubViewerMVC
//
//  Created by Andrei Dobysh on 27.11.20.
//

import UIKit

class RepositoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    var repositories: [RepositoryModel] = []
    
    @IBAction func goAction(_ sender: Any) {
        RepositoryModel.load(user: textField?.text ?? "") { completion in
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

extension RepositoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell") as! RepositoryCell
        let item = repositories[indexPath.row]
        cell.titleLabel.text = item.name
        cell.descriptionLabel.text = item.createdAt
        return cell
    }
    
}
