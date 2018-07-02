//
//  FactsViewController.swift
//  FactsTask
//
//  Created by Aditya Yadav on 02/07/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import UIKit

class FactsViewController: UIViewController {
    
    var tableView : UITableView!
    var factList = [FactsModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getList()
        
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64))
        
        self.view.addSubview(tableView)
        tableView.estimatedRowHeight = 60
        
        tableView.delegate = self
        tableView.dataSource = self
        let cell = FactTableCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        tableView.register(FactTableCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getList() {
        WebServices.getFactList(completionBlock: { (listModel) in
            
            print(listModel.title)
            
            DispatchQueue.main.async {
                self.title = listModel.title ?? ""
                
                if let list = listModel.rowList {
                    self.factList = list
                    self.tableView.reloadData()
                }

            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}


extension FactsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = factList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FactTableCell else {
            return UITableViewCell()
        }
        cell.configureCell(with: model)
        return cell
    }
}


