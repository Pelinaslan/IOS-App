//
//  imageViewController.swift
//  WondersOfTheWorldApp
//
//  Created by Pelin ASLAN on 6.05.2021.
//

import UIKit

class imageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    
    
    var selectedPlaceName = ""
    var selectedPlaceImage = UIImage()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeLabel.text = selectedPlaceName
        imageView.image = selectedPlaceImage

    
    }
    


}
