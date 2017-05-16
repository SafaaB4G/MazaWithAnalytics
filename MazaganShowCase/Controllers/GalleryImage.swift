//
//  GalleryImage.swift
//  MazaganShowCase
//
//  Created by Nabil Sossey Alaoui on 5/8/17.
//  Copyright © 2017 B4E. All rights reserved.
//

import Foundation
//
//  ViewControllerSegmented.swift
//  MazaganShowCase
//
//  Created by Nabil Sossey Alaoui on 4/3/17.
//  Copyright © 2017 B4E. All rights reserved.
//

import Foundation
import UIKit
import SJFluidSegmentedControl
import SKPhotoBrowser
import Presentr
import ActionButton
class GalleryImage: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate,SKPhotoBrowserDelegate{
    
    @IBOutlet var ButtomBack: UIButton!
    
    @IBAction func TappedButtom(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil )

    }
    
    var TypeHebergement: String!
    var urlDesc: String!
    
    var actionButton: ActionButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var toPass: String!
    var images = [SKPhotoProtocol]()
    var urlImage : String? = nil
    var arrayForGrid : Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ButtomBack.setTitle("Back", for: .normal)
        var photo : String! = nil
        
        
        print("l'url passe est :\(toPass)")
        
                let resp = Utils.getSyncDataFromUrl(url: toPass, httpMethod: "GET", parameter: "") as! NSArray
            
            //let photoResponse : NSDictionary = resp[0] as! NSDictionary
            //photo = photoResponse["Photo"] as! String
            print("The response is :\(resp.count)")
        
        for var i in (0..<resp.count)
        {
            print("im in the loop : the response here is : \(resp)")
            
        let photoResponse : NSDictionary = resp[i] as! NSDictionary
        photo = photoResponse["Photo"] as! String
            
        //urlImage = photo
            
        arrayForGrid.append(photo!)
            
            print("l'url de la photo finale : \(photo)")
        let photoToShow = SKPhoto.photoWithImageURL(photo)
        photoToShow.shouldCachePhotoURLImage = true // you can use image cache by true(NSCache)
        images.append(photoToShow)
            print("im in end of the loop ")

        }
        
        let frameCollection : CGRect = CGRect(x:0 , y: 0 , width : UIScreen.main.bounds.width , height : UIScreen.main.bounds.height)
        collectionView.frame = frameCollection
        // 2. create PhotoBrowser Instance, and present.
      
        // Static setup
        SKPhotoBrowserOptions.displayAction = false
        SKPhotoBrowserOptions.displayStatusbar = true
        
        //setupTestData()
        setupCollectionView()
        self.view.backgroundColor = UIColor.clear
        
        if (TypeHebergement != nil){
        //to show the description in the floating button (dans ce cas les lien des chambre et suite)
        print("l'url passe est :\(TypeHebergement)")
        let respDesc = Utils.getSyncDataFromUrl(url: TypeHebergement, httpMethod: "GET", parameter: "") as! NSArray
        
        
            
            
        print("The response is :\(respDesc.count)")
        
        for var i in (0..<respDesc.count)
        {
            print("im in the loop : the response here is : \(respDesc)")
            
            let DesecResponse : NSDictionary = respDesc[i] as! NSDictionary
            urlDesc = DesecResponse["description"] as! String
            
            
            
        }
        
        
        
        
        let plusImage = UIImage(named: "logoMazagan")!
        
        let typeHebergement = ActionButtonItem(title: "Description", image: plusImage)
        
        
        
        
        typeHebergement.action = { item in
            let presenter: Presentr = {
                let width = ModalSize.fluid(percentage: 0.80)
                let height = ModalSize.fluid(percentage: 0.20)
                let
                center = ModalCenterPosition.customOrigin(origin: CGPoint(x:100, y: 100))
                
                let customType = PresentationType.custom(width: width, height: height, center: center)
                
                let presenter = Presentr(presentationType: customType)
                presenter.transitionType = .coverHorizontalFromRight
                presenter.dismissTransitionType = .crossDissolve
                presenter.roundCorners = false
                presenter.backgroundColor = .clear
                presenter.backgroundOpacity = 0.5
                presenter.dismissOnSwipe = true
                presenter.dismissOnSwipeDirection = .top
                return presenter
                
                
            }()
            
            
            
            
            
            var alertController: AlertViewController {
                let alertController = Presentr.alertViewController(title: "Hébergement", body: self.urlDesc!)
                
                let okAction = AlertAction(title: "Read IT! 🤘", style: .destructive) { alert in
                    print("OK!!")
                }
                alertController.addAction(okAction)
                return alertController
            }
            
            presenter.viewControllerForContext = self
            
            presenter.shouldIgnoreTapOutsideContext = true
            
            self.customPresentViewController(presenter, viewController: alertController, animated: true, completion: nil)
            
        }
        actionButton = ActionButton(attachedToView: self.view, items: [ typeHebergement])
        actionButton.action = { button in button.toggleMenu() }
        actionButton.setTitle("+", forState: UIControlState())
        
        actionButton.backgroundColor = UIColor(red: 238.0/255.0, green: 130.0/255.0, blue: 34.0/255.0, alpha:1.0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


// MARK: - UICollectionViewDataSource

extension GalleryImage {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    @objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as? ExampleCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let url = NSURL(string: arrayForGrid[indexPath.row]) {
            if let imageData = NSData(contentsOf: url as URL) {
                let str64 = imageData.base64EncodedData(options: .lineLength64Characters)
                let data: NSData = NSData(base64Encoded: str64 , options: .ignoreUnknownCharacters)!
                cell.exampleImageView.image = UIImage(data : data as Data)

            }
        }
        cell.exampleImageView.contentMode = .scaleAspectFill
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension GalleryImage {
    @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ExampleCollectionViewCell else {
            return
            
            
        }
        guard let originImage = cell.exampleImageView.image else {
            return
            
            
            
            
        }
        
        let browser = SKPhotoBrowser(originImage: originImage, photos: images, animatedFromView: cell)
        browser.initializePageIndex(indexPath.row)
        browser.delegate = self
        // browser.updateCloseButton(UIImage(named: "casa.jpg")!)
        
        
        present(browser, animated: true, completion: {})
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            return CGSize(width: UIScreen.main.bounds.size.width / 2 - 70, height: 300)
            
            
        } else {
            return CGSize(width: UIScreen.main.bounds.size.width / 2 - 70, height: 200)
        }
    }
}


// MARK: - SKPhotoBrowserDelegate

extension GalleryImage {
    func didShowPhotoAtIndex(_ index: Int) {
        collectionView.visibleCells.forEach({$0.isHidden = false})
        collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
        
        
        print("didShowPhotoAtIndex")
        
    }
    
    func willDismissAtPageIndex(_ index: Int) {
        collectionView.visibleCells.forEach({$0.isHidden = false})
        collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
        print("willDismissAtPageIndex")
        
        
    }
    
    func willShowActionSheet(_ photoIndex: Int) {
        // do some handle if you need
    }
    
    func didDismissAtPageIndex(_ index: Int) {
        collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = false
    }
    
    func didDismissActionSheetWithButtonIndex(_ buttonIndex: Int, photoIndex: Int) {
        // handle dismissing custom actions
    }
    
    func removePhoto(index: Int, reload: (() -> Void)) {
        reload()
    }
    
    func viewForPhoto(_ browser: SKPhotoBrowser, index: Int) -> UIView? {
        return collectionView.cellForItem(at: IndexPath(item: index, section: 0))
    }
}

// MARK: - private

private extension GalleryImage {
    func setupTestData() {
        images = createLocalPhotos()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func createLocalPhotos() -> [SKPhotoProtocol] {
        return (0..<10).map { (i: Int) -> SKPhotoProtocol in
            let photo = SKPhoto.photoWithImage(UIImage(named: "image\(i%10).jpg")!)
            photo.caption = caption[i%10]
            photo.contentMode = .scaleAspectFill
            return photo
            
            
            
        }
    }
}

class ExampleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var exampleImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        exampleImageView.image = nil
        layer.cornerRadius = 25.0
        layer.masksToBounds = true
        exampleImageView.frame.size.width = 200
        exampleImageView.frame.size.height = 200

        
    }
    
    override func prepareForReuse() {
        exampleImageView.image = nil
    }
}

var caption = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
               "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
               "It has survived not only five centuries, but also the leap into electronic typesetting",
               "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
               "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
               "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
               "It has survived not only five centuries, but also the leap into electronic typesetting",
               "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
               "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
               "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
               "It has survived not only five centuries, but also the leap into electronic typesetting",
               "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
]
