//
//  RJExpandableTableView.swift
//  RJExpandableTableView
//
//  Created by 吴蕾君 on 16/5/12.
//  Copyright © 2016年 rayjuneWu. All rights reserved.
//

import UIKit

public protocol RJExpandableTableViewDataSource: UITableViewDataSource {
    
    func tableView(tableView: RJExpandableTableView, canExpandInSection section: Int) -> Bool
    func tableView(tableView: RJExpandableTableView, expandingCellForSection section: Int) -> RJExpandingTableViewCell
    func tableView(tableView: RJExpandableTableView, needsToDownloadDataForExpandSection section: Int) -> Bool
}

public protocol RJExpandableTableViewDelegate: UITableViewDelegate {
    func tableView(tableView: RJExpandableTableView, downloadDataForExpandableSection section: Int)
}

public class RJExpandableTableView: UITableView {
    
    lazy var canExpandedSections = [Int]()
    lazy var expandedSections = [Int]()
    lazy var downloadingSections = [Int]()
    
    public override var delegate: UITableViewDelegate? {
        get{
            return super.delegate
        }
        set{
            super.delegate = self
            expandDelegate = newValue as? RJExpandableTableViewDelegate
        }
    }
    
    public override var dataSource: UITableViewDataSource? {
        get{
            return super.dataSource
        }
        set{
            super.dataSource = self
            guard newValue is RJExpandableTableViewDataSource else {
                fatalError("Must has a datasource conforms to protocol 'RJExpandableTableViewDataSource'")
            }
            expandDataSource = newValue as! RJExpandableTableViewDataSource
        }
    }

    private weak var expandDataSource: RJExpandableTableViewDataSource!
    private weak var expandDelegate: RJExpandableTableViewDelegate?
    
    // MARK: Public
    public func expandSection(section: Int, animated: Bool) {
        guard !expandedSections.contains(section) else {
            return
        }
        if let downloadingIndex = downloadingSections.indexOf(section) {
            downloadingSections.removeAtIndex(downloadingIndex)
        }
        deselectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: section), animated: false)
        expandedSections.append(section)
        reloadData()
    }
    public func collapseSection(section: Int, animated: Bool) {
        if let index = expandedSections.indexOf(section) {
            expandedSections.removeAtIndex(index)
        }
        reloadData()
    }
    public func cancelDownloadInSection(section: Int) {
        guard let index = downloadingSections.indexOf(section) else {
            return
        }
        downloadingSections.removeAtIndex(index)
        reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: section)], withRowAnimation: .Automatic)
    }
    
    public func canExpandSection(section: Int) -> Bool {
        return canExpandedSections.contains(section)
    }
    
    public func isSectionExpand(section: Int) -> Bool {
        return true
    }
    
    // MARK: Private Helper
    private func canExpand(section:Int) -> Bool {
        return expandDataSource.tableView(self, canExpandInSection: section)
    }
    private func needsToDownload(section: Int) -> Bool {
        return expandDataSource.tableView(self, needsToDownloadDataForExpandSection: section)
    }
    private func downloadData(inSection section: Int) {
        downloadingSections.append(section)
        expandDelegate?.tableView(self, downloadDataForExpandableSection: section)
        reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: section)], withRowAnimation: .Automatic)
    }
}

// MARK: TableView DataSource
extension RJExpandableTableView : UITableViewDataSource {
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return expandDataSource.numberOfSectionsInTableView!(tableView)
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if canExpand(section) {
            canExpandedSections.append(section)
            if expandedSections.contains(section) {
                return expandDataSource.tableView(self, numberOfRowsInSection: section) + 1
            }else{
                return 1
            }
            
        }else{
            return expandDataSource.tableView(self, numberOfRowsInSection: section)
        }
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        if canExpand(section) {
            if indexPath.row == 0 {

                let expandCell = expandDataSource.tableView(self, expandingCellForSection: section)
                
                if downloadingSections.contains(section) {
                    expandCell.setLoading(true)
                }else{
                    expandCell.setLoading(false)
                    if (expandedSections.contains(section)) {
                        expandCell.setExpandStatus(RJExpandStatus.Expanded, animated: false)
                    } else {
                        expandCell.setExpandStatus(RJExpandStatus.Collapsed, animated: false)
                    }
                }
                return expandCell as! UITableViewCell
                
            }else{
                return expandDataSource.tableView(self, cellForRowAtIndexPath: indexPath)
            }
        }else{
            return expandDataSource.tableView(self, cellForRowAtIndexPath: indexPath)
        }
    }
    
}

// MARK: TableView Delegate
extension RJExpandableTableView : UITableViewDelegate {
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
        if canExpand(section) {
            if indexPath.row == 0 {
                if expandedSections.contains(section) {
                    collapseSection(section, animated: true)
                }else{
                    if needsToDownload(section) {
                        downloadData(inSection: section)
                    }else{
                        expandSection(section, animated: true)
                    }
                }
            }
        }
    }
    
}