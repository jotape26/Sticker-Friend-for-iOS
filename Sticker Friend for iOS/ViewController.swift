//
//  ViewController.swift
//  Sticker Friend for iOS
//
//  Created by João Leite on 13/11/18.
//  Copyright © 2018 João Leite. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var pack: StickerPack?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var imageData = UIImage(named: "Teste.png")
        
        imageData = resizeImage(image: imageData!, targetSize: CGSize(width: 96.0, height: 96.0))
        
        let data = imageData!.pngData()!
        
        do {
            try pack = StickerPack.init(identifier: "test", name: "Pacote de Teste", publisher: "João Leite", trayImagePNGData: data, publisherWebsite: nil, privacyPolicyWebsite: nil, licenseAgreementWebsite: nil)
            
            self.tableView.reloadData()
        } catch {
            // TODO - Show error message to user in the future.
            print(error)
        }
        
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        registerTableViewCells()
    }
    
    func registerTableViewCells(){
        let stickerCell = UINib(nibName: "StickerCell", bundle: nil)
        self.tableView.register(stickerCell, forCellReuseIdentifier: "StickerCell")
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


}

// MARK -TableViewDataSource Methods
extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StickerCell") as? StickerCell
        cell?.txtTitle.text = pack?.name
        cell?.txtAuthor.text = pack?.publisher
        return cell!
    }
}

