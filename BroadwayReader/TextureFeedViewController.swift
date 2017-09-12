//
//  TextureFeedViewController.swift
//  BroadwayReader
//
//  Created by Bob Law on 9/11/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import SafariServices

class TextureFeedViewController: ASViewController<ASDisplayNode>, ASTableDelegate, ASTableDataSource, RSSParserDelegate {

  let tableNode = ASTableNode.init(style: .plain)
  let parser: RSSParser
  
  var items: [RSSItem]?
  
  init() {
    parser = RSSParser.init(url: URL.init(string: "http://www.playbill.com/rss/news")!)
    
    super.init(node: tableNode)
    
    parser.delegate = self
    
    tableNode.delegate = self;
    tableNode.dataSource = self;
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Texture"
    
    parser.beginParsing()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let selectedRow = tableNode.indexPathForSelectedRow {
      tableNode.deselectRow(at: selectedRow, animated: true)
    }
  }
  
  // MARK: ASTableDataSource
  
  func numberOfSections(in tableNode: ASTableNode) -> Int {
    return 1
  }
  
  func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
    var numberOfRows = 0
    
    if let numberOfItems = items?.count {
      numberOfRows = numberOfItems
    }
    
    return numberOfRows
  }
  
  func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
    
    let item: RSSItem = items![indexPath.row]
    let viewModel = RSSItemViewModel.init(rssItem: item)
    
    let itemCellNode = RSSItemCellNode.init()
    itemCellNode.titleNode.attributedText = viewModel.attributedTitle
    itemCellNode.detailNode.attributedText = viewModel.attributedDetail
    itemCellNode.creatorNode.attributedText = viewModel.attributedCreator
    itemCellNode.timestampNode.attributedText = viewModel.attributedTimestamp
    
    return itemCellNode
  }
  
  // MARK: ASTableDelegate
  
  func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
    let item: RSSItem = items![indexPath.row]
    
    if let link = item.link {
      let trimmedLink = link.trimmingCharacters(in: .whitespacesAndNewlines)
      
      let url = URL.init(string: trimmedLink)
      let webViewController = SFSafariViewController.init(url: url!)
      webViewController.hidesBottomBarWhenPushed = true
      
      navigationController?.pushViewController(webViewController, animated: true)
    } else {
      tableNode.deselectRow(at: indexPath, animated: true)
    }
  }

  // MARK: RSSParserDelegate
  
  func didBeginParsing(url: URL) {
    // show loading?
  }
  
  func didEndParsing(url: URL, items: [RSSItem]) {
    self.items = items
    self.tableNode.reloadData()
  }
}
