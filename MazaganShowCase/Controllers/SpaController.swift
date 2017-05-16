    import Foundation
    import UIKit
    import SJFluidSegmentedControl
    import ActionButton
    import Presentr
    class SpaController: UIViewController {
        
        // MARK: - Outlets
        
        @IBOutlet weak var segmentedControl: SJFluidSegmentedControl!
        
      
        
        @IBOutlet var label: UILabel!
        
        
        // MARK: - View Lifecycle
        
        let imageView = UIImageView(image: UIImage(named: "logoMazagan")!)
        
        let rect:CGRect = CGRect( x: 0, y: 0 ,width: 1000, height : 80)
        var descriptionhammam :String? = nil
        var descriptionfitness :String? = nil
        var descriptionyoga :String? = nil
        var actionButton: ActionButton!
        var descriptionSpa :String? = nil


        override func viewDidLoad() {
            super.viewDidLoad()

            //calling the web service
            if Reachability.isInternetAvailable() {
                

            let resp = Utils.getSyncDataFromUrl(url: "http://www.beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/Spa", httpMethod: "GET", parameter: "") as! NSArray
            let hammamMenu : NSDictionary = resp[0] as! NSDictionary
            let fitnessMenu : NSDictionary = resp[1] as! NSDictionary
            let yogaMenu : NSDictionary = resp[2] as! NSDictionary
                
            descriptionhammam = hammamMenu["description"] as? String
            descriptionfitness = fitnessMenu["description"] as? String
            descriptionyoga = yogaMenu["description"] as? String
            }else{
                
            self.view.makeToast("No internet connection !")
                descriptionhammam = "No internet connection !"
                descriptionfitness = "No internet connection !"
                descriptionyoga = "No internet connection !"
            
            }
            
            
            
            
            print("test")
            if #available(iOS 8.2, *) {
                segmentedControl.textFont = .systemFont(ofSize: 16, weight: UIFontWeightSemibold)
            } else {
                segmentedControl.textFont = .boldSystemFont(ofSize: 16)
            }
            
            let segRect:CGRect = CGRect(x: segmentedControl.frame.origin.x, y: segmentedControl.frame.origin.y, width: UIScreen.main.bounds.size.width - 40.0, height: 60)
            
            segmentedControl.frame = segRect
            
            let scrollRect:CGRect = CGRect(x: 0, y: segmentedControl.frame.origin.y + segmentedControl.frame.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (segmentedControl.frame.origin.y + segmentedControl.frame.size.height))
            
            //the defaut value on load the page
            label.numberOfLines = 20
            label?.text = descriptionhammam
            label?.center = CGPoint(x: 300, y: 400)
            label?.textAlignment = .center
            label.frame = scrollRect
            
            
            //the code of floating buttom
            let twitterImage = UIImage(named: "logoMazagan")!
            
            let twitter = ActionButtonItem(title: "Spa", image: twitterImage)
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
                    let alertController = Presentr.alertViewController(title: "Spa", body: self.getDescription())
                    
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
                
                let urldescriptionSpa : String = "http://www.beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescriptionMenuPrincipale/spa"
                
                
                let respSpa = Utils.getSyncDataFromUrl(url: urldescriptionSpa, httpMethod: "GET", parameter: "") as! NSArray
                let SpaMenu : NSDictionary = respSpa[0] as! NSDictionary
                
                
                descriptionSpa = (SpaMenu["description"] as? String)!
                
                
                
                return descriptionSpa!
                
            }else
                
            {
                descriptionSpa = " No internet connection "        }
            return " No internet connection "
            
        }

       
        // to be conformed to the protocol
        
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            // Uncomment the following line to set the current segment programmatically.
            // segmentedControl.currentSegment = 1
        }
        
        
        
                
        
        
    }
    
    // MARK: - SJFluidSegmentedControl Data Source Methods
    
    extension SpaController: SJFluidSegmentedControlDataSource {
        
        func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
            return 3
        }
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                              titleForSegmentAtIndex index: Int) -> String? {
            
            if index == 0 {
                return "spa et hammam".uppercased()
            } else if index == 1 {
                return "fitness".uppercased()
            }
            return "hot yoga".uppercased()
        }
        
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
            
            if (toIndex == 0){
                
                label?.text = descriptionhammam
                label?.textColor = UIColor.black
                print("ii'm in 1")
                
            }
            if (toIndex == 1){
                label?.text = descriptionfitness
                
                print("ii'm in 2")
                
                
            }
            if (toIndex == 2){
                label?.text =
                descriptionyoga
                print("ii'm in 3")
                
            }
            
            
            //        self.segmentedControl(segmentedControl, didScrollWithXOffset:offset)
            
        }
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                              gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor] {
            switch index {
            case 0:
                return [UIColor(red: 51 / 255.0, green: 149 / 255.0, blue: 182 / 255.0, alpha: 1.0),
                        UIColor(red: 97 / 255.0, green: 199 / 255.0, blue: 234 / 255.0, alpha: 1.0)]
            case 1:
                return [UIColor(red: 227 / 255.0, green: 206 / 255.0, blue: 160 / 255.0, alpha: 1.0),
                        UIColor(red: 225 / 255.0, green: 195 / 255.0, blue: 128 / 255.0, alpha: 1.0)]
            case 2:
                return [UIColor(red: 21 / 255.0, green: 94 / 255.0, blue: 119 / 255.0, alpha: 1.0),
                        UIColor(red: 9 / 255.0, green: 82 / 255.0, blue: 107 / 255.0, alpha: 1.0)]
            default:
                break
            }
            return [.clear]
        }
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                              gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor] {
            switch bounce {
            case .left:
                return [UIColor(red: 51 / 255.0, green: 149 / 255.0, blue: 182 / 255.0, alpha: 1.0)]
            case .right:
                return [UIColor(red: 9 / 255.0, green: 82 / 255.0, blue: 107 / 255.0, alpha: 1.0)]
            }
        }
        
    }
    
    // MARK: - SJFluidSegmentedControl Delegate Methods
    
    extension SpaController: SJFluidSegmentedControlDelegate {
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didScrollWithXOffset offset: CGFloat) {
            
            print("Scrolling offset: \(offset)")
            
            //        scrollView.contentOffset.x += offset
        }
        
}

