//
//  FabricTableViewController.swift
//  Yidingzhi
//
//  Created by flybywind on 15/11/26.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import UIKit

class FabricTableViewController: UITableViewController {

    // MARK: properties
    var receiveData : SuitStatus?
    var contents: [FabricInfo]?
    // MARK: constant
    let fabricMap = [
        "西服":[
            FabricInfo(Fid: "abc/de 100", FabricBrand: "世佳宝", FabricMaterial: "100%羊毛", FabricPrice: 2000, FabricImage: "xifu_1"),
            FabricInfo(Fid: "abc/de 200", FabricBrand: "维达莱", FabricMaterial: "90%羊毛 10%羊绒", FabricPrice: 5000, FabricImage: "xifu_2"),
            FabricInfo(Fid: "abc/de 300", FabricBrand: "世佳宝", FabricMaterial: "100%羊毛", FabricPrice: 2000, FabricImage: "xifu_1"),
            FabricInfo(Fid: "abc/de 400", FabricBrand: "维达莱", FabricMaterial: "90%羊毛 10%羊绒", FabricPrice: 5000, FabricImage: "xifu_2"),
        ],
        "衬衫":[
            FabricInfo(Fid: "123-56 2", FabricBrand: "1857", FabricMaterial: "100%棉", FabricPrice: 550, FabricImage: "chenshan_1"),
            FabricInfo(Fid: "123-56 4", FabricBrand: "1857", FabricMaterial: "100%棉", FabricPrice: 1550, FabricImage: "chenshan_2"),
            FabricInfo(Fid: "123-56 6", FabricBrand: "鲁泰", FabricMaterial: "100%棉", FabricPrice: 550, FabricImage: "chenshan_1"),
            FabricInfo(Fid: "123-56 8", FabricBrand: "鲁泰", FabricMaterial: "100%棉", FabricPrice: 1550, FabricImage: "chenshan_2"),
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let s = receiveData {
            log.debug("receive data: \(s.dressType)")
            contents = fabricMap[s.dressType]
        }else {
            log.debug("not receive data!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let c = contents {
            return c.count
        }else {
            return 0
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FabricCell", forIndexPath: indexPath) as! FabricDetailCell
        if let c = contents {
            let fabricInfo = c[indexPath.row]
            cell.setInfo(fabricInfo)
            self.tableView.rowHeight = 160
            return cell
        } else {
            return FabricDetailCell()
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
