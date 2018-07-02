//
//  FactTableCell.swift
//  FactsTask
//
//  Created by Aditya Yadav on 02/07/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import UIKit

class FactTableCell: UITableViewCell {

    
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var imgView = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        addConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        descriptionLabel.text = ""
        imgView.image = nil
    }

    
    private func setupSubviews(){
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(descriptionLabel)
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imgView)
        
        descriptionLabel.numberOfLines = 0
    }
    
    func configureCell (with info: FactsModel) {
        titleLabel.text = info.title ?? "Untitled"
        descriptionLabel.text = info.description
        imgView.backgroundColor = UIColor.lightGray
    }
    
    private func addConstraint() {
        
        let views: [String: Any] = ["title": titleLabel,"description": descriptionLabel, "img" : imgView]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let imgHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[img(40)]-20-[title]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        
        allConstraints.append(contentsOf: imgHorizontalConstraints)
        
        let imgVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[img(40)]", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        
        allConstraints.append(contentsOf: imgVerticalConstraint)
        
        
        let titleVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[title(30)]", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        allConstraints.append(contentsOf: titleVerticalConstraint)
        
        let descriptionHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[img]-20-[description]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        allConstraints.append(contentsOf: descriptionHorizontalConstraints)
        
        let descriptionVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[title]-5-[description]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        allConstraints.append(contentsOf: descriptionVerticalConstraint)
        
        self.contentView.addConstraints(allConstraints)
    }
}
