//
//  UIKitFeedViewController.swift
//  BroadwayReader
//
//  Created by Bob Law on 9/12/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

import UIKit

class UIKitFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RSSParserDelegate {

  let tableView = UITableView.init(frame: .zero, style: .plain)
  
  let parser: RSSParser
  
  var items: [RSSItem]?
  
  init() {
    parser = RSSParser.init(url: URL.init(string: "http://www.playbill.com/rss/news")!)
    
    super.init(nibName: nil, bundle: nil)
    
    parser.delegate = self
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 44.0
    tableView.register(RSSItemTableViewCell.classForCoder(), forCellReuseIdentifier: "RSSItemTableViewCell")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "UIKit"
    
    tableView.frame = view.bounds
    view.addSubview(tableView)
    
    parser.beginParsing()
  }
  
  // MARK: UITableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var numberOfRows = 0
    
    if let numberOfItems = items?.count {
      numberOfRows = numberOfItems
    }
    
    return numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RSSItemTableViewCell") as? RSSItemTableViewCell
    
    let item: RSSItem = items![indexPath.row]
    let viewModel = RSSItemViewModel.init(rssItem: item)
    
    cell?.titleLabel.attributedText = viewModel.attributedTitle
    cell?.detailLabel.attributedText = viewModel.attributedDetail
    cell?.creatorLabel.attributedText = viewModel.attributedCreator
    cell?.timestampLabel.attributedText = viewModel.attributedTimestamp
    
    return cell!
  }
  
  // MARK: RSSParserDelegate
  
  func didBeginParsing(url: URL) {
    // show loading?
  }
  
  func didEndParsing(url: URL, items: [RSSItem]) {
    self.items = items
    self.tableView.reloadData()
  }
}
