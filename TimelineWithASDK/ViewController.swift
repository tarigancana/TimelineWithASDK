//
//  ViewController.swift
//  TimelineWithASDK
//
//  Created by Rencana Tarigan on 3/30/17.
//  Copyright © 2017 cana. All rights reserved.
//
import AsyncDisplayKit

class ViewController: ASViewController<ASDisplayNode> {
    var tableNode: ASTableNode { return node as! ASTableNode }
    var dataProvider = [DummyData]()

    init() {
        super.init(node: ASTableNode(style: .grouped))
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.sectionHeaderHeight = 0.000001
        tableNode.view.sectionFooterHeight = 0.000001
        tableNode.view.separatorStyle = .none

        createDummyData()
    }

    func createDummyData() {
        dataProvider.append(DummyData(date: Date(), title: "Title 1", content: "dummy data with very long content that need to be wrap or truncate"))

        dataProvider.append(DummyData(date: Date(), title: "Title 1", content: "dummy data with very long content that need to be wrap or truncate"))

        dataProvider.append(DummyData(date: Date(), title: "Title 1", content: "dummy data with very long content that need to be wrap or truncate"))

        dataProvider.append(DummyData(date: Date(), title: "Title 1", content: "dummy data with very long content that need to be wrap or truncate"))

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewController: ASTableDelegate {

}

extension ViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.count
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock: () -> ASCellNode = {
            let data = self.dataProvider[indexPath.row]
            return DataCellNode(data: data)
        }
        return cellNodeBlock
    }
}

struct DummyData {
    var date: Date
    var title: String
    var content: String
}
