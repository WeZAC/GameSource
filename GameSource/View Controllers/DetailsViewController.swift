//
//  DetailsViewController.swift
//  GameSource
//
//  Created by Langtian Qin on 4/17/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var images = [UIImage]()
    @IBOutlet weak var imageScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Load image gallery for inspected app
        // THEN: Load the loaded images into the image array
        for i in 0..<images.count{
            let newImageView=UIImageView()
            newImageView.image=images[i]
            newImageView.contentMode = .scaleAspectFit
            let xPos=self.view.frame.width*CGFloat(i)
            newImageView.frame=CGRect(x:xPos,y:0,width:self.view.frame.width,height:self.view.frame.height)
            
            imageScrollView.contentSize.width=imageScrollView.frame.width*CGFloat(i+1)
            imageScrollView.addSubview(newImageView)
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
