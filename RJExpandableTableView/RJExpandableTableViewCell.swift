//
//  RJExpandableTableViewCell.swift
//  RJExpandableTableView
//
//  Created by 吴蕾君 on 16/5/12.
//  Copyright © 2016年 rayjuneWu. All rights reserved.
//

import Foundation

enum RJExpandStatus {
    case Collapsed,Expanded
}

protocol RJExpandingTableViewCell {
    func setLoading(loading:Bool)
    func setExpandStatus(status: RJExpandStatus,animated:Bool)
}