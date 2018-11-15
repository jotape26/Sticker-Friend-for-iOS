//
//  MainScreenViewController.swift
//  Sticker Friend for iOS
//
//  Created by João Leite on 13/11/18.
//  Copyright © 2018 João Leite. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var packList: [StickerPack] = []
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblErrorDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *){
            navigationItem.largeTitleDisplayMode = .always
        }
    
        self.tableView.delegate = self
        self.tableView.dataSource = self
        registerTableViewCells()
        
        
    }
    
    func registerTableViewCells(){
        let stickerPackListCell = UINib(nibName: "StickerPackListCell", bundle: nil)
        self.tableView.register(stickerPackListCell, forCellReuseIdentifier: "StickerPackListCell")
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    @IBAction func btnCreatePack(_ sender: Any) {
        performSegue(withIdentifier: "CreateOrEditSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateOrEditSegue"{
            let createVC = segue.destination as! CreateViewController
            createVC.callback = { result in
                self.packList.append(result)
                self.tableView.reloadData()
            }
        }
    }
}

// MARK -TableViewDataSource Methods
extension MainScreenViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(packList.isEmpty){
            lblTitle.isHidden = false
            lblErrorDescription.isHidden = false
            return 0
        }else{
            lblTitle.isHidden = true
            lblErrorDescription.isHidden = true
            return packList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StickerPackListCell") as? StickerPackListCell
        cell?.txtTitle.text = packList[indexPath.row].name
        cell?.txtAuthor.text = packList[indexPath.row].publisher
        cell?.imgSticker1.image = packList[indexPath.row].stickers[0].imageData.image
        cell?.imgSticker2.image = packList[indexPath.row].stickers[1].imageData.image
        cell?.imgSticker3.image = packList[indexPath.row].stickers[2].imageData.image
        cell?.imgSticker4.image = packList[indexPath.row].stickers[3].imageData.image
        cell?.imgSticker5.image = packList[indexPath.row].stickers[4].imageData.image
        return cell!
    }
}
