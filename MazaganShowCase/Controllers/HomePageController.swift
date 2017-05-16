//
//  HomePageController.swift
//  MazaganShowCase
//
//  Created by Nabil Sossey Alaoui on 4/25/17.
//  Copyright © 2017 B4E. All rights reserved.
//

import UIKit
import ActionButton

class HomePageController: UIViewController,iCarouselDataSource, iCarouselDelegate {
    
    
    @IBOutlet var myViewCarousel: iCarousel!
    var actionButton: ActionButton! 
    var myImages : NSMutableArray = NSMutableArray()
    var selectedIndex : Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myImages = NSMutableArray(array: ["azem","logoMazagan","jdida","kech","rabat"])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create an image array and make sure to all these images in the project directory
        //myImages = NSMutableArray(array: ["a","b","c","d"])
        myViewCarousel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        myViewCarousel.dataSource = self
        
        myViewCarousel.type = .coverFlow2
        myViewCarousel.backgroundColor = UIColor.clear
        
        
        //the code of floating buttom 
//        let twitterImage = UIImage(named: "logoMazagan")!
//
//        let twitter = ActionButtonItem(title: "Twitter", image: twitterImage)
        //twitter.action = { item in self.test() }
        
        let plusImage = UIImage(named: "logoMazagan")!

        let google = ActionButtonItem(title: "Show The Map", image: plusImage)
        google.action = { item in print("here we will present to next controller ") }
        
        actionButton = ActionButton(attachedToView: self.view, items: [google])
        actionButton.action = { button in button.toggleMenu() }
        actionButton.setTitle("+", forState: UIControlState())
        
        actionButton.backgroundColor = UIColor(red: 238.0/255.0, green: 130.0/255.0, blue: 34.0/255.0, alpha:1.0)
        
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return myImages.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView
    {
        
        var itemView: UIImageView
        itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        if let img = UIImage(named: "\(myImages.object(at: index))"){
            itemView.image = img
            itemView.contentMode = .center
            itemView.autoresizingMask = [.flexibleTopMargin, .flexibleHeight, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleWidth]
            itemView.contentMode = UIViewContentMode.scaleAspectFit
            
            print("image name: \(myImages.object(at: index))")
        }
        
        
        return itemView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
    //When segue triggers, pass selected image to the destination view controller.
    //overriding prepareForSegue method
    
    
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        myViewCarousel.scrollToItem(at: index, animated: true)
    }
    func carouselWillBeginScrollingAnimation(_ carousel: iCarousel) {
        print("scrolling!!!");
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        print("index Did Change!!!");
    }
    
}
