//
//  RSSItemTableViewCell.swift
//  BroadwayReader
//
//  Created by Bob Law on 9/12/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

import UIKit

class RSSItemTableViewCell: UITableViewCell {
  
  let titleLabel = UILabel()
  let detailLabel = UILabel()
  let creatorLabel = UILabel()
  let timestampLabel = UILabel()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    detailLabel.translatesAutoresizingMaskIntoConstraints = false
    creatorLabel.translatesAutoresizingMaskIntoConstraints  = false
    timestampLabel.translatesAutoresizingMaskIntoConstraints = false
    
    titleLabel.numberOfLines = 0
    detailLabel.numberOfLines = 0
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(detailLabel)
    contentView.addSubview(creatorLabel)
    contentView.addSubview(timestampLabel)
    
    let views: [String: UIView] = ["titleLabel": titleLabel, "detailLabel": detailLabel, "creatorLabel": creatorLabel, "timestampLabel": timestampLabel]
    var constraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    
    constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[titleLabel]-15-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[creatorLabel]-(<=1000)-[timestampLabel]-15-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[detailLabel]-15-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    
    constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-7-[titleLabel]-4-[detailLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    
    constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[detailLabel]-4-[creatorLabel]-7-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    
    constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[detailLabel]-4-[timestampLabel]-7-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    
    NSLayoutConstraint.activate(constraints)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    titleLabel.attributedText = nil
    detailLabel.attributedText = nil
    creatorLabel.attributedText = nil
    timestampLabel.attributedText = nil
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
