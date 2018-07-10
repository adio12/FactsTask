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
    var refreshControl = UIRefreshControl()
    var dataSource = FactDataSource()
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadTableData()
        self.view.backgroundColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupSubviews(){
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        addConstraint()
        tableView.estimatedRowHeight = 150
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(reloadTableData), for: UIControlEvents.valueChanged)
        tableView.allowsSelection = false
        tableView.register(FactTableCell.self, forCellReuseIdentifier: Constant.factCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func addConstraint() {
        
        let table = "tableView"
        let views: [String: Any] = [table: tableView]
        var allConstraints: [NSLayoutConstraint] = []
        
        let tableHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[\(table)]-0-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        allConstraints.append(contentsOf: tableHorizontalConstraints)
        
        let tableVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[\(table)]-0-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        allConstraints.append(contentsOf: tableVerticalConstraint)
        
        self.view.addConstraints(allConstraints)
    }
    
    @objc func reloadTableData(){
        
        func reloadTable(){
            if let _ = self.tableView {
                self.tableView.reloadData()
            } else {
                self.setupSubviews()
                self.tableView.reloadData()
            }
        }
        
        dataSource.getList(completionBlock: {
            DispatchQueue.main.async {
                
                self.title = self.dataSource.title
                self.refreshControl.endRefreshing()

                reloadTable()
            }
            
        }) { (errorString) in
            
            DispatchQueue.main.async {
                if self.refreshControl.isRefreshing {
                    
                    self.refreshControl.endRefreshing()
                    self.tableView?.contentOffset.y = 0

                } else {
                    reloadTable()
                }
            }
            
            CommonMethods.showAlertViewController(viewController: self, withAlertTitle: Constant.kAlertTitle, withAlertMessage: errorString)
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension FactsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.factCellIdentifier, for: indexPath) as? FactTableCell else {
            return UITableViewCell()
        }
        cell.datasource = dataSource.dataForCell(index: indexPath.row)
        return cell
    }
}

