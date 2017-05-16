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
import ITRFlipper
import ActionButton
import Presentr
import Toast_Swift

//class MyClass: UIView {
//    
//    @IBOutlet var image: UIImageView!
//    @IBOutlet var menuname: UILabel!
//    @IBOutlet var descriptions: UILabel!
//    
//    override func awakeFromNib(){
//    
//    }
//        let view: UIView =
//
//    
//    func setAtribute(images : String , nameMenu : String , descriptionsS : String) {
//        
//        self.image.image = UIImage(named: images)
//        self.menuname.text = nameMenu
//        self.menuname.textColor = UIColor.red
//        self.descriptions.text = descriptionsS
//        self.descriptions.textColor = UIColor.brown
//    
//    }
//    
//    
//    
//}

class RestaurationView: UIViewController ,ITRFlipperDataSource{

    
    var actionButton: ActionButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var descriptionOne :String? = nil
    var descriptionTwo :String? = nil
    var descriptionTree :String? = nil
    var descriptionFor :String? = nil
    var descriptionFive :String? = nil
    var descriptionSex :String? = nil
    var descriptionSeven :String? = nil
    var descriptionEight :String? = nil
    var descriptionNine :String? = nil
    var descriptionTen :String? = nil
    var descriptionEleven :String? = nil
    var descriptionTwelve :String? = nil
    var descriptionThirteen :String? = nil
    var descriptionForteen :String? = nil
    var descriptionFifteen :String? = nil
    var descriptionSexteen :String? = nil
    var typeMenu : String!
    var descriptionResaturation :String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //calling the web service 
        if Reachability.isInternetAvailable() {

        let resp = Utils.getSyncDataFromUrl(url: "http://www.beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/Restauration", httpMethod: "GET", parameter: "") as! NSArray
        let one : NSDictionary = resp[0] as! NSDictionary
        let two : NSDictionary = resp[1] as! NSDictionary
        let three : NSDictionary = resp[2] as! NSDictionary
        let four : NSDictionary = resp[3] as! NSDictionary
        let five : NSDictionary = resp[4] as! NSDictionary
        let sex : NSDictionary = resp[5] as! NSDictionary
        let seven : NSDictionary = resp[6] as! NSDictionary
        let eight : NSDictionary = resp[7] as! NSDictionary
        let nine : NSDictionary = resp[8] as! NSDictionary
        let ten : NSDictionary = resp[9] as! NSDictionary
        let eleven : NSDictionary = resp[10] as! NSDictionary
        let twelve : NSDictionary = resp[11] as! NSDictionary
        let thirteen : NSDictionary = resp[12] as! NSDictionary
        let forteen : NSDictionary = resp[13] as! NSDictionary
        let fifteen : NSDictionary = resp[14] as! NSDictionary
        let sexteen : NSDictionary = resp[15] as! NSDictionary

        //get the description

        descriptionOne = one["description"] as? String
        descriptionTwo = two["description"] as? String
        descriptionTree = three["description"] as? String
        descriptionFor = four["description"] as? String
        descriptionFive = five["description"] as? String
        descriptionSex = sex["description"] as? String
        descriptionSeven = seven["description"] as? String
        descriptionEight = eight["description"] as? String
        descriptionNine = nine["description"] as? String
        descriptionTen = ten["description"] as? String
        descriptionEleven = eleven["description"] as? String
        descriptionTwelve = twelve["description"] as? String
        descriptionThirteen = thirteen["description"] as? String
        descriptionForteen = forteen["description"] as? String
        descriptionFifteen = fifteen["description"] as? String
        descriptionSexteen = sexteen["description"] as? String
            
        }
        else{
            self.view.makeToast("No internet connection !")
            descriptionOne = "No internet connection !"
            descriptionTwo = "No internet connection !"
            descriptionTree = "No internet connection !"
            
            descriptionFor = "No internet connection !"
            descriptionFive = "No internet connection !"
            descriptionSex = "No internet connection !"
            descriptionSeven = "No internet connection !"
            descriptionEight = "No internet connection !"
            descriptionNine = "No internet connection !"
            descriptionTen = "No internet connection !"
            descriptionEleven = "No internet connection !"
            descriptionTwelve = "No internet connection !"
            descriptionThirteen = "No internet connection !"
            descriptionForteen = "No internet connection !"
            descriptionFifteen = "No internet connection !"
            descriptionSexteen = "No internet connection !"
            

            
        }

        let flipperView : ITRFlipper = ITRFlipper(frame : self.view.frame)
        print("test")
        
//        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height / 2
//        let displayWidth: CGFloat = self.view.frame.width
//        let displayHeight: CGFloat = self.view.frame.height
        
        
        flipperView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        flipperView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        flipperView.backgroundColor = UIColor.clear
        flipperView.dataSource = self
        self.view.addSubview(flipperView)
        
        //the code of floating buttom
        let twitterImage = UIImage(named: "logoMazagan")!
        
        let twitter = ActionButtonItem(title: "Restauration", image: twitterImage)
        twitter.action = { item in
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
                
//                crossDissolve
//                case coverVertical
//                case coverVerticalFromTop
//                case coverHorizontalFromRight
//                case coverHorizontalFromLef
            }()
            
            

            //calling the dialog :
            //first create the dialogcontoroller :
            
            var alertController: AlertViewController {
                let alertController = Presentr.alertViewController(title: "Restauration", body: self.getDescription())
                
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
        
        actionButton = ActionButton(attachedToView: self.view, items: [twitter])
        actionButton.action = { button in button.toggleMenu() }
        actionButton.setTitle("+", forState: UIControlState())
        
        actionButton.backgroundColor = UIColor(red: 238.0/255.0, green: 130.0/255.0, blue: 34.0/255.0, alpha:1.0)
        
        
        
        
        
    }
    
    func getDescription() -> String {
        
        if Reachability.isInternetAvailable() {

             let urldescriptionRestauration : String = "http://www.beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/MenuSimple/3"
        
       
        let respRestauration = Utils.getSyncDataFromUrl(url: urldescriptionRestauration, httpMethod: "GET", parameter: "") as! NSArray
        let restaurationMenu : NSDictionary = respRestauration[0] as! NSDictionary
        
        
         descriptionResaturation = (restaurationMenu["description"] as? String)!
        
        

        return descriptionResaturation!
        
        }else
        
        {
               descriptionResaturation = " No internet connection "        }
        return " No internet connection "

    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    func number(ofPagesinFlipper flipper: ITRFlipper!) -> Int {
        print("im in numer of page")
        return 16
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        
        print("you tapped me : \(typeMenu)")
        // Your action
        if Reachability.isInternetAvailable() {

        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "GalleryImage") as! GalleryImage
        destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/"+typeMenu
        navigationController?.pushViewController(destination, animated: false)
        }else
            
        {
            self.view.makeToast("No internet connection !")
        }

        
    }
    
    public func view(forPage page: Int, in flipper: ITRFlipper!) -> UIView!{
        
        
        print("j'ai rentrer : \(page)")

        let myview : UIView = UIView(frame: CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height))
        let image : UIImageView = UIImageView()
        let imageFrame : CGRect = CGRect(x:0,y:100,width:UIScreen.main.bounds.width,height:600)
        image.frame = imageFrame
        //the buttom
        let buttom :UIButton = UIButton()
        let buttomFrame : CGRect = CGRect(x:0,y:20,width:UIScreen.main.bounds.width,height:100)
        buttom.frame = buttomFrame
        buttom.setTitle("RESTAURATION", for: .normal)
        buttom.setTitleColor(UIColor.brown , for: .normal)
        
        
        //frames 
        let descriptionMenuFrame : CGRect = CGRect(x:0,y:(UIScreen.main.bounds.height/2) + 100 ,width:UIScreen.main.bounds.width,height:((UIScreen.main.bounds.height) - (UIScreen.main.bounds.height/2) + 100))
         let titreMenuFrame  : CGRect = CGRect(x:40,y:UIScreen.main.bounds.height/2,width:UIScreen.main.bounds.width,height:100)
        
        // ends frames
        let labelDescription : UILabel = UILabel()
        //styling the labels description

        labelDescription.textAlignment = .center
        labelDescription.frame = descriptionMenuFrame
        labelDescription.textColor = UIColor.red
        labelDescription.numberOfLines = 20
        
        //styling the name menu
        let menuName : UILabel = UILabel()
        menuName.textColor = UIColor.brown
        
        menuName.frame = titreMenuFrame

        //add the action for the uimage :
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector
            (imageTapped(tapGestureRecognizer:)))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)

        switch page {
        case 1:
            //if( imageMenu! = nil &&  )
            image.image = UIImage(named: "logoMazagan")
            labelDescription.text = descriptionOne
            menuName.text = "Market Place"
            typeMenu = "MarketPlace"
    print("index num : \(page)")
            break
        case 2 :
            image.image = UIImage(named: "casa")
            labelDescription.text = descriptionTwo
            menuName.text = "Olives"
            typeMenu = "Olives"

            
            break
        case 3 :
            image.image = UIImage(named: "casa")
            labelDescription.text = descriptionTree
            menuName.text = "Morjana"
            typeMenu = "Morjana"

            break

        case 4 :
            image.image = UIImage(named: "casa")
            labelDescription.text = descriptionFor
            menuName.text = "Jin-Ja"
            typeMenu = "Jin-Ja"
            
            break

        case 5 :
            image.image = UIImage(named: "casa")
            labelDescription.text = descriptionFive
            menuName.text = "Al Firma"
            typeMenu = "AlFirma"

            break

        case 6 :
            image.image = UIImage(named: "oualidia")
            labelDescription.text = descriptionSex
            menuName.text = "Sel de Mer"
            typeMenu = "SeldeMer"
            break

        case 7 :
            image.image = UIImage(named: "casa")
            labelDescription.text = descriptionSeven
            menuName.text = "La Cave"
            typeMenu = "LaCave"
            break

        case 8 :
            image.image = UIImage(named: "logoMazagan")
            labelDescription.text = descriptionEight
            menuName.text = "Chiringuito"
            typeMenu = "Chiringuito"
            break

        case 9 :
            image.image = UIImage(named: "casa")
            labelDescription.text = descriptionNine
            menuName.text = "Beach Barbecue"
            typeMenu = "BeachBarbecue"
            break

        case 10 :
            image.image = UIImage(named: "azem")
            labelDescription.text = descriptionTen
            menuName.text = "Pizzeria"
            typeMenu = "Pizzeria"
            break

        case 11 :
            image.image = UIImage(named: "casa")
            labelDescription.text = descriptionEleven
            menuName.text = "Club house"
            typeMenu = "Clubhouse"
            break

        case 12 :
            image.image = UIImage(named: "rabat")
            labelDescription.text = descriptionTwelve
            menuName.text = "Oasis"
            typeMenu = "Oasis"
            break

        case 13 :
            image.image = UIImage(named: "casa")
            labelDescription.text = descriptionThirteen
            menuName.text = "Tutti Frutti"
            typeMenu = "TuttiFrutti"
            break

        case 14 :
            image.image = UIImage(named: "azem")
            labelDescription.text = descriptionForteen
            menuName.text = "Jockey Club"
            typeMenu = "JockeyClub"
            break

        case 15 :
            image.image = UIImage(named: "casa")
            labelDescription.text = descriptionFifteen
            menuName.text = "Aterium"
            typeMenu  = "Aterium"

            break
            
        case 16 :
            image.image = UIImage(named: "rabat")
            labelDescription.text = descriptionSexteen
            menuName.text = "Alias"
            typeMenu = "Alias"
            break

        default:
            image.image = UIImage(named: "azem")
            labelDescription.text = "No Menu"
            typeMenu=nil

        
        }
        
        print("index num : \(page)")
        myview.addSubview(buttom)
        myview.addSubview(image)
        myview.addSubview(menuName)
        myview.addSubview(labelDescription)
        return myview
        
    }
  
    
}
