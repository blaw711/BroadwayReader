//
//  RSSItemViewModel.swift
//  BroadwayReader
//
//  Created by Bob Law on 9/11/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

import UIKit

class RSSItemViewModel: NSObject {
  
  let attributedTitle: NSAttributedString?
  let attributedDetail: NSAttributedString?
  let attributedCreator: NSAttributedString?
  let attributedTimestamp: NSAttributedString?
  
  init(rssItem: RSSItem) {
    if let title = rssItem.title {
      let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
      attributedTitle = NSAttributedString.init(string: trimmedTitle, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline)])
    } else {
      attributedTitle = nil
    }
    
    if let detail = rssItem.detail {
      let trimmedDetail = detail.trimmingCharacters(in: .whitespacesAndNewlines)
      attributedDetail = NSAttributedString.init(string: trimmedDetail, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .callout), NSForegroundColorAttributeName: UIColor.gray])
    } else {
      attributedDetail = nil
    }
    
    if let creator = rssItem.creator {
      let trimmedCreator = creator.trimmingCharacters(in: .whitespacesAndNewlines)
      let by = "By:"
      let fullCreator = String.init(format: "%@ %@", by, trimmedCreator)
      attributedCreator = NSAttributedString.init(string: fullCreator, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .caption1), NSForegroundColorAttributeName: UIColor.lightGray])
    } else {
      attributedCreator = nil
    }
    
    if let timestamp = rssItem.date {
      let trimmedTimestamp = timestamp.trimmingCharacters(in: .whitespacesAndNewlines)
      attributedTimestamp = NSAttributedString.init(string: trimmedTimestamp, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .caption1), NSForegroundColorAttributeName: UIColor.lightGray])
    } else {
      attributedTimestamp = nil
    }
    
    super.init()
  }

}
