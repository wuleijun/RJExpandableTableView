//
//  ViewController.swift
//  RJExpandableTableView
//
//  Created by 吴蕾君 on 16/5/12.
//  Copyright © 2016年 rayjuneWu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let expandCellId = "ExpandTableViewCell"
    
    @IBOutlet weak var tableView: RJExpandableTableView!{
        didSet{
            tableView.registerNib(UINib(nibName: expandCellId, bundle: nil), forCellReuseIdentifier: expandCellId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController:RJExpandableTableViewDataSource {
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 10
    }
    
    func tableView(tableView: RJExpandableTableView, canExpandInSection section: Int) -> Bool {
        return true
    }
    
    func tableView(tableView: RJExpandableTableView, needsToDownloadDataForExpandSection section: Int) -> Bool {
        return true
    }
    
    func tableView(tableView: RJExpandableTableView, expandingCellForSection section: Int) -> RJExpandingTableViewCell{
        let expandCell = tableView.dequeueReusableCellWithIdentifier(expandCellId) as! ExpandTableViewCell
        return expandCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "subCell")
        cell.textLabel?.text = "subcell\(indexPath.section)-\(indexPath.row)"
        cell.backgroundColor = UIColor.lightGrayColor()
        return cell
    }
}

extension ViewController: RJExpandableTableViewDelegate {
    
    func tableView(tableView: RJExpandableTableView, heightForExpandingCellAtSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: RJExpandableTableView, downloadDataForExpandableSection section: Int) {
        
        delay(2){
            if section % 2 == 0{
                tableView.expandSection(section, animated: true)
            }else{
                print("Download failed!")
                tableView.cancelDownloadInSection(section)
            }
        }
    }
}
