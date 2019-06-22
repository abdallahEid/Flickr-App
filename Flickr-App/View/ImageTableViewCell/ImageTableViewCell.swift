//
//  FlickrTableViewCell.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/21/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import UIKit
import SDWebImage

class ImageTableViewCell: UITableViewCell, ImageTableViewCellDelegate {

    @IBOutlet weak var flickerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    func displayImage(url: String) {
        flickerImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: url))
    }
    
    
}
