//
//  ChooseCategory.swift
//  append
//
//  Created by Patrick Cui on 9/12/21.
//

import UIKit

protocol CategoryDelegate {
    func onSelected(category: String)
}

class ChooseCategory: UIViewController {
    
    var delegate: CategoryDelegate?
    
    private let titleText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.semibold.withSize(size: 18)
        label.textAlignment = .center
        return label
    }()
    private let cancelButton = IconButton(symbol: "xmark", color: Color.destructive)
    private let tableView = UITableView()
    
    @objc func back() {
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        view.addSubview(titleText)
        titleText.text = "Choose Category"
        titleText.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        titleText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleText.widthAnchor.constraint(equalToConstant: 250).isActive = true
        view.addSubview(cancelButton)
        cancelButton.centerYAnchor.constraint(equalTo: titleText.centerYAnchor).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        cancelButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 80, width: view.bounds.width, height: view.bounds.height - 80)
        tableView.backgroundColor = Color.bg
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
    }

}

extension ChooseCategory: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier) as! CategoryCell
        cell.backgroundColor = Color.bg
        cell.category = passTypes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelected(category: passTypes[indexPath.row])
        dismiss(animated: true)
    }
    
    
}
