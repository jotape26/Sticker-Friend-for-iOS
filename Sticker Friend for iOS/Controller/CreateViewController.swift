//
//  CreateViewController.swift
//  Sticker Friend for iOS
//
//  Created by João Leite on 14/11/18.
//  Copyright © 2018 João Leite. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    var callback : ((StickerPack)->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        sendBackNewPack()
    }

    func sendBackNewPack(){
        var imageData = UIImage(named: "sticker1.png")
        imageData = resizeImage(image: imageData!, targetSize: CGSize(width: 96.0, height: 96.0))
        let data = imageData!.pngData()!
        do {
            let pack = try StickerPack.init(identifier: "test", name: "Pacote que veio da tela criar", publisher: "João Leite", trayImagePNGData: data, publisherWebsite: nil, privacyPolicyWebsite: nil, licenseAgreementWebsite: nil)
            
            try pack.addSticker(contentsOfFile: "sticker1.png", emojis: nil)
            try pack.addSticker(contentsOfFile: "sticker2.png", emojis: nil)
            try pack.addSticker(contentsOfFile: "sticker3.png", emojis: nil)
            try pack.addSticker(contentsOfFile: "sticker4.png", emojis: nil)
            try pack.addSticker(contentsOfFile: "sticker5.png", emojis: nil)
            
            callback!(pack)
        } catch {
            // TODO - Show error message to user in the future.
            print(error)
        }
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
