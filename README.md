# RJExpandableTableView

[![Version](	https://img.shields.io/cocoapods/v/RJExpandableTableView.svg)](http://cocoadocs.org/docsets/RJExpandableTableView)
[![License](https://img.shields.io/cocoapods/l/RJExpandableTableView.svg?style=flat)](http://cocoadocs.org/docsets/RJExpandableTableView)
[![Platform](https://img.shields.io/cocoapods/p/RJExpandableTableView.svg?style=flat)](http://cocoadocs.org/docsets/RJExpandableTableView)

RJExpandableTableView is a UITableView subclass that gives you easy access to expandable and collapsable sections by just implementing a few more delegate and dataSource protocols.
It is written in Swift.

## How to use RJExpandableTableView

* Installation

```
pod 'RJExpandableTableView'
```

* Load the RJExpandableTableView in a UITableViewController

```swift
- (void)loadView
{
    self.tableView = [[RJExpandableTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
}
```

* Implement the **RJExpandableTableViewDatasource** protocol

```swift
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
```

* Implement the **RJExpandableTableViewDelegate** protocol

```swift
extension ViewController: RJExpandableTableViewDelegate {
    
    func tableView(tableView: RJExpandableTableView, heightForExpandingCellAtSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: RJExpandableTableView, downloadDataForExpandableSection section: Int) {
        //...
    }
}

```

## Sample Screenshots
<https://github.com/wuleijun/RJExpandableTableView/blob/master/screen%20shot%200.png>
