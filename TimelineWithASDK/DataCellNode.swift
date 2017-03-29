//
//  DataCellNode.swift
//  TimelineWithASDK
//
//  Created by Rencana Tarigan on 3/30/17.
//  Copyright © 2017 cana. All rights reserved.
//

import AsyncDisplayKit

class DataCellNode: ASCellNode {
    var data: DummyData!
    let contentNode = ASTextNode()
    let titleNode = ASTextNode()
    let dotNode = ASImageNode()
    let timeNode = ASTextNode()
    let bigBorderDotNode  = ASImageNode()
    let verticalLine = ASDisplayNode()
    let verticalLineTop = ASDisplayNode()
    let divider = ASDisplayNode()

    init(data: DummyData){
        super.init()
        self.data = data
        self.backgroundColor = UIColor.white
        self.selectionStyle = .none

        titleNode.attributedText = NSAttributedString(string: data.title)
        titleNode.truncationMode = .byTruncatingTail
        titleNode.maximumNumberOfLines = 2

        contentNode.attributedText = NSAttributedString(string: data.content)
        contentNode.truncationMode = .byTruncatingTail
        contentNode.maximumNumberOfLines = 1

        timeNode.attributedText = NSAttributedString(string: timeFormatter().string(from: data.date))

        dotNode.style.preferredSize = CGSize(width: 5, height: 5)
        dotNode.cornerRadius = 2.5
        dotNode.backgroundColor = UIColor.black

        bigBorderDotNode.style.preferredSize = CGSize(width: 10, height: 10)
        bigBorderDotNode.cornerRadius = 5
        bigBorderDotNode.borderColor = UIColor.black.cgColor
        bigBorderDotNode.borderWidth = 1

        verticalLine.backgroundColor = UIColor.black
        addSubnode(verticalLine)

        verticalLineTop.backgroundColor = UIColor.black
        addSubnode(verticalLineTop)

        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let centerSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: dotNode)
        let dotSpec = ASOverlayLayoutSpec(child: bigBorderDotNode, overlay: centerSpec)

        let topSpec = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 3,
            justifyContent: .center,
            alignItems: .center,
            children: [dotSpec, timeNode]
        )

        let metaSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 3,
            justifyContent: .start,
            alignItems: .start,
            children: [titleNode, contentNode]
        )

        metaSpec.style.flexShrink = 1

        let bottomSpec = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 11,
            justifyContent: .start,
            alignItems: .start,
            children: [divider, metaSpec]
        )

        let mainSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .start,
            children: [topSpec, bottomSpec]
        )

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 18, left: 13, bottom: 0, right: 0), child: mainSpec)
    }

    func timeFormatter() -> DateFormatter {
        let format = DateFormatter()
        format.dateFormat = "h:mm a"
        return format
    }

    override func layout() {
        super.layout()
        verticalLine.frame = CGRect(x: 18, y: 29, width: 1, height: calculatedSize.height)
        verticalLineTop.frame = CGRect(x: 18, y: 0, width: 1, height: 20)
    }
}
