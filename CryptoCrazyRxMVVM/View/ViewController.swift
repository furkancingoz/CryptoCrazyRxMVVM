//
//  ViewController.swift
//  CryptoCrazyRxMVVM
//
//  Created by Furkan Cingöz on 30.10.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var cryptosList = [Crypto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate = self
        tableView.dataSource = self
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().downloadCurrencies(url: url) { result in
            switch result {
            case .success(let cryptos):
                self.cryptosList = cryptos
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptosList[indexPath.row].currency
        content.secondaryText = cryptosList[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
}

