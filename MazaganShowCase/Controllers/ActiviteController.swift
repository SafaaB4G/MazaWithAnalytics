import Foundation
import UIKit
import SJFluidSegmentedControl
import ActionButton
import Presentr
    class ActiviteController: UIViewController ,UITableViewDataSource, UITableViewDelegate , UIWebViewDelegate{
        
        // MARK: - Outlets
        
        @IBOutlet weak var segmentedControl: SJFluidSegmentedControl!
        
        @IBOutlet weak var scrollView: UIScrollView!
        var  myTableView1:UITableView? = nil
        var  myView2:UIView?  = nil
        var actionButton: ActionButton!
        //private let Array: NSArray = ["jadida","azem","oua","casa","kech","rabat"]
        let jadida = UIImageView(image: UIImage(named: "jadida")!)
        var descriptinSport : String? = nil
        var descriptinExcursion : String? = nil


        var logoImage: [UIImage] = [
            UIImage(named: "jadida")!,
            UIImage(named: "azem")!,
            UIImage(named: "oua")!,
            UIImage(named: "casa")!,
            UIImage(named: "kech")!,
            UIImage(named: "rabat")!
            
        ]
        
        // MARK: - View Lifecycle
        
        let imageView = UIImageView(image: UIImage(named: "logoMazagan")!)
        
        let rect:CGRect = CGRect( x: 0, y: 0 ,width: 1000, height : 1000)
        var descriptinShopping : String? = nil
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
             if Reachability.isInternetAvailable() {
                
            let resp = Utils.getSyncDataFromUrl(url: "http://www.beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/Shopping", httpMethod: "GET", parameter: "") as! NSArray
            let ActiviteMenu : NSDictionary = resp[0] as! NSDictionary
            descriptinShopping = ActiviteMenu["description"] as? String
             }else{
                
                self.view.makeToast("No internet connection !")
                descriptinShopping = "No internet connection !"
                
                
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
            
            scrollView.frame = scrollRect
            
            let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height / 2
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
            
            //setting the web view
            
            let myView:UIWebView = UIWebView(frame: CGRect(x: 0, y: 0 , width: displayWidth, height: displayHeight - barHeight))
          //  let localfilePath = Bundle.main.url(forResource: "sport", withExtension: "html");
            
            let htmlString:String! = "<h2>Activités terrestres :</h2><br><Mazagan dispose d un large choix d activités <br>en plein air<ul>" +
            "<li>Tennis</li><li>Karting</li><li>Footing</li><li>Tir à l arc</li><li>Paintball</li><li>VTT</li>" +
            "<li>Marche nordique</li>" + "<li>Tennis de table</li><li>Le Cavalier</li></ul></li><h2>Activités nautiques</h2>" +
            "<br><ul><li>Beach volley</li><li>Jet-ski </li>" +
            "<li>Surf / Body-board</li><li>Quad / Buggy</li></ul><br>"
            myView.loadHTMLString(htmlString, baseURL: nil)
            myView.delegate = self
        
            //setting the table view
            
            myTableView1 = UITableView(frame: CGRect(x: UIScreen.main.bounds.size.width, y: 0 , width: displayWidth, height: displayHeight - barHeight))
            myTableView1?.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell2")
            myTableView1?.dataSource = self
            myTableView1?.delegate = self
            self.myTableView1?.separatorColor = UIColor.clear

            
            myTableView1?.backgroundColor = UIColor.orange
            //setting the label 
            
             myView2 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width * 2, y: 0 , width: displayWidth, height: displayHeight - barHeight))
            
            let scrollRect2:CGRect = CGRect(x: 0, y: segmentedControl.frame.origin.y + segmentedControl.frame.size.height - 200, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (segmentedControl.frame.origin.y + segmentedControl.frame.size.height))
            scrollView.frame = scrollRect
            
            myView2?.backgroundColor = UIColor.purple
            let label:UILabel = UILabel()
            label.textColor = UIColor.black
            label.backgroundColor = UIColor.brown
            label.text = descriptinShopping
            label.center = CGPoint(x: 300, y: 400)
            label.textAlignment = .center
            label.frame = scrollRect2
            
            self.myView2?.addSubview(label)
            self.scrollView.addSubview(myView)
            self.scrollView.addSubview(myTableView1!)
            self.scrollView.addSubview(myView2!)
            
            //the code of floating buttom
            
            //first is to call the web service 
                       // create the flaoting button and fill it
            
            let twitterImage = UIImage(named: "logoMazagan")!
            let plusImage = UIImage(named: "logoMazagan")!
            let Excursion = ActionButtonItem(title: "Excursion", image: twitterImage)
            let sport = ActionButtonItem(title: "Sport", image: twitterImage)
            
            
            
            if Reachability.isInternetAvailable() {
                
                
                let resp1 = Utils.getSyncDataFromUrl(url: "http://www.beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/Excursions", httpMethod: "GET", parameter: "") as! NSArray
                let one : NSDictionary = resp1[0] as! NSDictionary
                descriptinExcursion =  one["description"] as? String
                
            }
            else{
                descriptinExcursion = " No internet connection !!!!!"
                
            }
            if Reachability.isInternetAvailable() {
                
                
                let resp1 = Utils.getSyncDataFromUrl(url: "http://www.beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/Sports", httpMethod: "GET", parameter: "") as! NSArray
                let one : NSDictionary = resp1[0] as! NSDictionary
                descriptinSport =  one["description"] as? String
                
            }
            else{
                descriptinSport = " No internet connection !!!!!"
                
            }

            
            
            
            

            
            //dialog of excursion
            Excursion.action = { item in
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
                
                
                
                //calling the dialog :
                //first create the dialogcontoroller :
                
                var alertController: AlertViewController {
                    let alertController = Presentr.alertViewController(title: "Excursion", body: self.descriptinExcursion!)
                    
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
            sport.action = { item in
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
                
                
                
                //calling the dialog :
                //first create the dialogcontoroller :
                
                var alertController: AlertViewController {
                    let alertController = Presentr.alertViewController(title: "Sport", body: self.descriptinSport!)
                    
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
            

            
            
            
            
            actionButton = ActionButton(attachedToView: self.view, items: [Excursion, sport])
            actionButton.action = { button in button.toggleMenu() }
            actionButton.setTitle("+", forState: UIControlState())
            
            actionButton.backgroundColor = UIColor(red: 238.0/255.0, green: 130.0/255.0, blue: 34.0/255.0, alpha:1.0)
            
            
            
            

            
        }
        
       
        
        func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
            return true
        }
        
        // to be conformed to the protocol
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 6
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "GalleryImage") as! GalleryImage
             if Reachability.isInternetAvailable() {
                switch indexPath.row {
                case 0:
                    destination.TypeHebergement = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/ElJadida"
                    
                    destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/ElJadida"
                    navigationController?.pushViewController(destination, animated: true)
                    break
                case 1:
                    destination.TypeHebergement = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/azemmour"
                    
                    destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/azemmour"
                    navigationController?.pushViewController(destination, animated: true)
                    break
                case 2:
                    destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/oualidia"
                    destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/oualidia"
                    navigationController?.pushViewController(destination, animated: true)
                    break
                case 3:
                    destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/casablanca"
                    
                    destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/casablanca"
                    navigationController?.pushViewController(destination, animated: true)

                    break
                case 4:
                    destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/marrakech"
                    
                    destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/marrakech"
                    navigationController?.pushViewController(destination, animated: true)

                    break
                case 5:
                    destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/rabat"
                    
                    destination.toPass = "http://www.beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/rabat"
                    navigationController?.pushViewController(destination, animated: true)

                    break
                    
                    
                default:
                    print("nothing to do !!!")
                
                
            }
                
             }
             else{
                descriptinSport = " No internet connection !!!!!"
                
            }
            


        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell2", for: indexPath as IndexPath)
            imageView.frame = rect
            cell.imageView?.image = imageView.image

            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "El Jadida"
                cell.imageView?.image = logoImage[0]

            case 1:
                cell.textLabel?.text = "Azemmour"
                cell.imageView?.image = logoImage[1]

            case 2:
                cell.textLabel?.text = "Oualidia"
                cell.imageView?.image = logoImage[2]

            case 3:
                cell.textLabel?.text = "Casablanca"
                cell.imageView?.image = logoImage[3]

            case 4:
                cell.textLabel?.text = "Marrakech"
                cell.imageView?.image = logoImage[4]

            case 5:
                cell.textLabel?.text = "Rabat"
                cell.imageView?.image = logoImage[5]

            default:
                cell.textLabel?.text = "Marrakech"
                cell.imageView?.image = logoImage[5]

                
            }
            

            
            return cell
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            // Uncomment the following line to set the current segment programmatically.
            // segmentedControl.currentSegment = 1
        }
        
        
    }
    
    // MARK: - SJFluidSegmentedControl Data Source Methods
    
    extension ActiviteController: SJFluidSegmentedControlDataSource {
        
        func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
            return 3

        }
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                              titleForSegmentAtIndex index: Int) -> String? {
            
            if index == 0 {
                return "Sport & loisirs".uppercased()
                
            } else if index == 1 {
                return "excursions".uppercased()
            }
            return "shopping".uppercased()
        }
        
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
            
            let offset:CGFloat = UIScreen.main.bounds.size.width * CGFloat(toIndex - fromIndex);
            
            scrollView.contentOffset.x += offset
            
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
    
    extension ActiviteController: SJFluidSegmentedControlDelegate {
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didScrollWithXOffset offset: CGFloat) {
            
            print("Scrolling offset: \(offset)")
            
            //        scrollView.contentOffset.x += offset
        }
        
}

