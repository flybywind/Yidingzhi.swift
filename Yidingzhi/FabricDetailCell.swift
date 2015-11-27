//
//  FabricDetailCell.swift
//  Yidingzhi
//
//  Created by flybywind on 15/11/26.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import UIKit

class FabricDetailCell: UITableViewCell {
    var fabricInfo: FabricInfo?
    @IBOutlet weak var fabricImage: UIImageView!
    @IBOutlet weak var fidLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var materialLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    let sourcePath = NSBundle.mainBundle()

    func setInfo(fabricInfo: FabricInfo) {
        self.fabricInfo = fabricInfo
        
        fidLabel.text = fabricInfo.Fid
        brandLabel.text = fabricInfo.FabricBrand
        materialLabel.text = fabricInfo.FabricMaterial
        priceLabel.text = "\(fabricInfo.FabricPrice)￥"
        
        
        if let imagFile = sourcePath.pathForResource(fabricInfo.FabricImage,
            ofType: "jpg") {
            fabricImage.image = UIImage(contentsOfFile: imagFile)
        } else {
            log.debug("no such fabric picture: \(fabricInfo.FabricImage)")
        }
    }

}
