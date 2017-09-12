//
//  RSSParser.swift
//  BroadwayReader
//
//  Created by Bob Law on 9/11/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

import Foundation

protocol RSSParserDelegate {
  func didBeginParsing(url: URL)
  func didEndParsing(url: URL, items: [RSSItem])
}

class RSSParser: NSObject, XMLParserDelegate {
  
  private var parser: XMLParser?
  private var url: URL?
  
  var isParsing = false
  
  var items: [RSSItem]?
  
  var delegate: RSSParserDelegate?

  private var currentItem: RSSItem?
  private var currentElement: String?

 convenience init(url: URL) {
    self.init()
  
  items = [RSSItem]()
  
  self.url = url
  
    parser = XMLParser.init(contentsOf: url)
    parser?.delegate = self
    parser?.shouldResolveExternalEntities = false
  }
  
  func beginParsing() -> Void {
    parser?.parse()
  }
  
  func abortParsing() -> Void {
    parser?.abortParsing()
  }
  
  // MARK: XMLParserDelegate
  
  func parserDidStartDocument(_ parser: XMLParser) {
    isParsing = true
    
    delegate?.didBeginParsing(url: url!)
  }
  
  func parserDidEndDocument(_ parser: XMLParser) {
    isParsing = false
    
    delegate?.didEndParsing(url: url!, items: items!)
  }
  
  func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
    isParsing = false
  }
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    currentElement = elementName
    
    if currentElement == "item" {
      currentItem = RSSItem()
    }
  }
  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
        
    if let element = currentElement {
      switch element {
      case "title":
        currentItem?.title?.append(string)
      case "description":
        currentItem?.detail?.append(string)
      case "link":
        currentItem?.link?.append(string)
      case "dc:creator":
        currentItem?.creator?.append(string)
      case "dc:date":
        currentItem?.date?.append(string)
      case "dc:subject":
        currentItem?.subject?.append(string)
      default:
        break
      }
    }
  }
  
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if elementName == "item" {
      if let item = currentItem {
        items?.append(item)
      }
    }
  }
}
