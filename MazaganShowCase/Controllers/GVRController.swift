//
//  GVRCOntroller.swift
//  MazaganShowCase
//
//  Created by Nabil Sossey Alaoui on 5/18/17.
//  Copyright © 2017 B4E. All rights reserved.
//

import UIKit


class GVRCOntroller: UIViewController {

    enum Media {
        static var photoArray = ["CasaPanoramic.jpg"]
        static let videoURL = "https://s3.amazonaws.com/ray.wenderlich/elephant_safari.mp4"
    }

    
    @IBOutlet var VRView: GVRPanoramaView!
    var currentView: UIView?
    var currentDisplayMode = GVRWidgetDisplayMode.embedded
    override func viewDidLoad() {
        super.viewDidLoad()
        VRView.isHidden = true
        VRView.delegate = self
        VRView.load(UIImage(named: Media.photoArray.first!),
                         of: GVRPanoramaImageType.mono)
        
        VRView.enableCardboardButton = true
        VRView.enableFullscreenButton = true
        
        
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


extension GVRCOntroller: GVRWidgetViewDelegate {
    func widgetView(_ widgetView: GVRWidgetView!, didLoadContent content: Any!) {
        
        if content is UIImage {
            VRView.isHidden = false
        }
    }
    
    func widgetView(_ widgetView: GVRWidgetView!, didFailToLoadContent content: Any!,
                    withErrorMessage errorMessage: String!)  {
        
        print("Eroor to load centent !!!")

    }
    
    func widgetView(_ widgetView: GVRWidgetView!, didChange displayMode: GVRWidgetDisplayMode) {
        
        currentView = widgetView
        currentDisplayMode = displayMode
        
    }
    
    func widgetViewDidTap(_ widgetView: GVRWidgetView!) {
        
        guard currentDisplayMode != GVRWidgetDisplayMode.embedded else {return}
        // 2
        if currentView == VRView {
            Media.photoArray.append(Media.photoArray.removeFirst())
            VRView?.load(UIImage(named: Media.photoArray.first!),
                              of: GVRPanoramaImageType.mono)
        }
        
        if currentView == VRView && currentDisplayMode != GVRWidgetDisplayMode.embedded {
            view.isHidden = true
        } else {
            view.isHidden = false
        }
    }
}
