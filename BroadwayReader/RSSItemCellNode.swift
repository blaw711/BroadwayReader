//
//  RSSItemCellNode.swift
//  BroadwayReader
//
//  Created by Bob Law on 9/11/17.
//  Copyright © 2017 Bob Law. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class RSSItemCellNode: ASCellNode {
  
  let titleNode = ASTextNode()
  let detailNode = ASTextNode()
  let timestampNode = ASTextNode()
  let creatorNode = ASTextNode()
  
  override init() {
    super.init()
    
   self.automaticallyManagesSubnodes = true
    
  }

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let spacer = ASLayoutSpec()
    spacer.style.flexGrow = 1.0
    
    let horizontalCreatorTimeStackLayout = ASStackLayoutSpec.init(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .stretch, children: [creatorNode, spacer, timestampNode])
    
    let verticalStackLayout = ASStackLayoutSpec.init(direction: .vertical, spacing: 4.0, justifyContent: .center, alignItems: .stretch, children: [titleNode, detailNode, horizontalCreatorTimeStackLayout])
    return ASInsetLayoutSpec.init(insets: UIEdgeInsetsMake(7, 15, 7, 15), child: verticalStackLayout)
  }
}
