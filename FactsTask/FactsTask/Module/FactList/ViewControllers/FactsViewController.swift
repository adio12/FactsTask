//
//  FactsViewController.swift
//  FactsTask
//
//  Created by Aditya Yadav on 02/07/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import UIKit

class FactsViewController: UIViewController {
    
    //MARK: - Properties

    var tableView : UITableView!
    var factList = [FactsModel]()
    var refreshControl = UIRefreshControl()
    
    //MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getList()
        
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64))
        
        self.view.addSubview(tableView)
        tableView.estimatedRowHeight = 150
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(reloadTableData), for: UIControlEvents.valueChanged)
        tableView.allowsSelection = false
        tableView.register(FactTableCell.self, forCellReuseIdentifier: "cell")

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func reloadTableData(){
        getList()
    }
    
    // Get list from json
    func getList() {
        WebServices.getFactList(completionBlock: { (listModel) in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.title = listModel.title ?? ""
                
                if let list = listModel.rowList {
                    self.factList = list
                    self.tableView.reloadData()
                }

            }
        }) { (error) in
            self.refreshControl.endRefreshing()
            print(error.localizedDescription)
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension FactsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FactTableCell else {
            return UITableViewCell()
        }
        cell.setDataSource(datasource: self, index: indexPath.row)
        return cell
    }
}

//MARK: - CellDatasource

extension FactsViewController : CellDatasource {
    
    func datasourceOfCell(for index: Int) -> TableCellModel {
        let model = factList[index]
        return TableCellModel(model: model)
    }
}


