//
//  FactsViewController.swift
//  FactsTask
//
//  Created by Aditya Yadav on 02/07/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import UIKit

class FactsViewController: UIViewController {
    
    var titleLabel = UILabel()
    var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getList()
        titleLabel.text = "uiiio"
        titleLabel.textAlignment = .center
        self.view.backgroundColor = UIColor.yellow
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(titleLabel)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64))
        
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.brown

        
        let cell = FactTableCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        tableView.register(FactTableCell.self, forCellReuseIdentifier: "cell")
        
        setupConstraint()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraint() {
        

        let views: [String: Any] = ["titleLabel": titleLabel,"tableView": tableView]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        
//        let lableConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[titleLabel] -50-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[titleLabel]-50-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        
                allConstraints += horizontalConstraints

        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[titleLabel(50)]", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        
        //        self.view.addConstraint(lableConstraint)
                allConstraints += verticalConstraints

        
        self.view.addConstraints(allConstraints)
        
        
    }
    
    
    func getList() {
        WebServices.getFactList(completionBlock: { (listModel) in
            
            print(listModel.title)
            
            for element in listModel.rowList {
                print(element.title)
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension FactsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FactTableCell else {
            return UITableViewCell()
        }
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

class FactTableCell : UITableViewCell {
    
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var imgView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        self.contentView.backgroundColor = UIColor.blue
        addConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubviews(){
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(descriptionLabel)
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imgView)
        
        descriptionLabel.numberOfLines = 0
    }
    
    func configureCell () {
        titleLabel.text = "dghd"
        descriptionLabel.text = "fdguybcd dfbhbdfb jdfhnbbv dfhbvhbfd"
        imgView.backgroundColor = UIColor.yellow
    }
    
    func addConstraint() {
        
        let views: [String: Any] = ["title": titleLabel,"description": descriptionLabel, "img" : imgView]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let imgHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[img(50)]-20-[title]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        
        allConstraints.append(contentsOf: imgHorizontalConstraints)
        
        let imgVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[img(50)]", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)

        allConstraints.append(contentsOf: imgVerticalConstraint)

        
        let titleVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[title(30)]", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        allConstraints.append(contentsOf: titleVerticalConstraint)

        let descriptionHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[img]-20-[description]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        allConstraints.append(contentsOf: descriptionHorizontalConstraints)

        let descriptionVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[title]-5-[description]-10-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        allConstraints.append(contentsOf: descriptionVerticalConstraint)

        self.contentView.addConstraints(allConstraints)
    }
}
