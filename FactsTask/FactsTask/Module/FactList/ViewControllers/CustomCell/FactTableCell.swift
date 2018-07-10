//
//  FactTableCell.swift
//  FactsTask
//
//  Created by Aditya Yadav on 02/07/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import UIKit

class FactTableCell: UITableViewCell {
    
    enum SubViews : String {
        case title, image, description
    }
    
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var imgView = UIImageView()
    private var imgUrlString : String!
    
    
    var datasource : FactViewModel = FactViewModel() {
        
        didSet {
            setCellValues()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // reset cell before reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        descriptionLabel.text = ""
        imgView.image = nil
        imgUrlString = nil
    }
    
    private func setupSubviews(){
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(descriptionLabel)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imgView)
        descriptionLabel.numberOfLines = 0
        addConstraint()
    }
    
    
    private func setCellValues() {
        titleLabel.text = datasource.title ?? "Untitled"
        descriptionLabel.text = datasource.description
        imgView.backgroundColor = UIColor.lightGray
        if let urlString = datasource.imgURL, !urlString.isEmpty {
            self.imgUrlString = urlString
        }
        displayImage()
    }

    // Retrieve/download images
    private func displayImage() {
        
        if let urlString = imgUrlString, !urlString.isEmpty {
            DispatchQueue.global(qos: .background).async {
                //"This is run on the background queue"
                WebServices.getImageFromURL(urlString: urlString, completionBlock: { (img) in
                    
                    DispatchQueue.main.async {
                        //"This is run on the main queue"
                        self.imgView.image = img
                    }
                })
            }
        }
    }
    
    // constraint to set position of views
    private func addConstraint() {
        
        let title = SubViews.title.rawValue
        let img = SubViews.image.rawValue
        let description = SubViews.description.rawValue
        let views: [String: Any] = [SubViews.title.rawValue: titleLabel,SubViews.description.rawValue: descriptionLabel, SubViews.image.rawValue : imgView]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let imgHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[\(img)(40)]-20-[\(title)]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        
        allConstraints.append(contentsOf: imgHorizontalConstraints)
        
        let imgVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[\(img)(40)]", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        
        allConstraints.append(contentsOf: imgVerticalConstraint)
        
        let titleVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[\(title)(30)]", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        allConstraints.append(contentsOf: titleVerticalConstraint)
        
        let descriptionHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[\(img)]-20-[\(description)]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        allConstraints.append(contentsOf: descriptionHorizontalConstraints)
        
        let descriptionVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[\(title)]-15-[\(description)]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: views)
        allConstraints.append(contentsOf: descriptionVerticalConstraint)
        
        self.contentView.addConstraints(allConstraints)
    }
}
