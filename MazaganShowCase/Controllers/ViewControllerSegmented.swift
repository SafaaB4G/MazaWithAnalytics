
import Foundation
import UIKit
import SJFluidSegmentedControl
import ActionButton
import Presentr
import Toast_Swift


class ViewControllerSegmented: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    // MARK: - Outlets
    
    @IBOutlet weak var segmentedControl: SJFluidSegmentedControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var descriptinvilla : String? = nil
    var actionButton: ActionButton!
    
    var descChambre :String? = nil
    var descSuite :String? = nil
    
    
    // MARK: - View Lifecycle
    let imageView = UIImageView(image: UIImage(named: "logoMazagan")!)
    let image1 = UIImageView(image: UIImage(named: "PoolViewRoom")!)
    let image2 = UIImageView(image: UIImage(named: "PartialOceanViewRoom")!)
    let image3 = UIImageView(image: UIImage(named: "OceanViewRoom")!)
    let image4 = UIImageView(image: UIImage(named: "mazaganbeach")!)
    
    
    let rect:CGRect = CGRect( x: 0, y: 0 ,width: 1000, height : 80)
    var myTableView:UITableView? = nil
    var myTableView1:UITableView? = nil
    var myView3:UIView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isInternetAvailable() {
            
            
            let resp = Utils.getSyncDataFromUrl(url: "http://www.beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/villa", httpMethod: "GET", parameter: "") as! NSArray
            
            let villaMenu : NSDictionary = resp[0] as! NSDictionary
            descriptinvilla = villaMenu["description"] as? String
            

        }
        else{
            descriptinvilla = "No data because no internet connection !!!!!"
            self.view.makeToast("No internet connection !")
            
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
        
        
        let scrollRect2:CGRect = CGRect(x: 0, y: segmentedControl.frame.origin.y + segmentedControl.frame.size.height - 200, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (segmentedControl.frame.origin.y + segmentedControl.frame.size.height))
        scrollView.frame = scrollRect
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height / 2
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: 0 , width: displayWidth, height: displayHeight - barHeight))
        myTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView?.dataSource = self
        myTableView?.delegate = self
        self.myTableView?.separatorColor = UIColor.clear
        
        
        myTableView1 = UITableView(frame: CGRect(x: UIScreen.main.bounds.size.width, y: 0 , width: displayWidth, height: displayHeight - barHeight))
        myTableView1?.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView1?.dataSource = self
        myTableView1?.delegate = self
        myTableView1?.separatorColor = UIColor.clear
        
        myView3 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width * 2, y: 0 , width: displayWidth, height: displayHeight - barHeight))
        
        //            let rectlabel : CGRect = CGRect(x:0 ,y :segmentedControl.frame.origin.y+segmentedControl.frame.height , width :displayWidth , height : displayHeight - barHeight )
        //
        //myView3?.backgroundColor = UIColor.purple
        let label:UILabel = UILabel()
        label.textColor = UIColor.black
        label.text = descriptinvilla
        label.numberOfLines = 20
        label.center = CGPoint(x: 300, y: 400)
        label.textAlignment = .center
        label.frame = scrollRect2
        
        self.myView3?.addSubview(label)
        self.scrollView.addSubview(myTableView!)
        self.scrollView.addSubview(myTableView1!)
        self.scrollView.addSubview(myView3!)
        
        
        //dialog chambre/Suite
        
        
        
        
        if Reachability.isInternetAvailable() {
            
            
            let resp1 = Utils.getSyncDataFromUrl(url: "http://www.beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/chambre", httpMethod: "GET", parameter: "") as! NSArray
            let one : NSDictionary = resp1[0] as! NSDictionary
            descChambre =  one["description"] as? String
            
        }
        else{
            descChambre = " No internet connection !!!!!"
            
        }
        
        if Reachability.isInternetAvailable() {
            
            
            let resp2 = Utils.getSyncDataFromUrl(url: "http://www.beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/suite", httpMethod: "GET", parameter: "") as! NSArray
            let two : NSDictionary = resp2[0] as! NSDictionary
            
            descSuite = two["description"] as? String
            
            
            
        }
        else{
            descSuite = " No internet connection !!!!!"
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        //the code of floating buttom
        let twitterImage = UIImage(named: "logoMazagan")!
        let plusImage = UIImage(named: "logoMazagan")!
        
        let Chambre = ActionButtonItem(title: "Chambre", image: twitterImage)
        
        let Suite = ActionButtonItem(title: "Suite", image: plusImage)
        
        Chambre.action = { item in
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
                


                let alertController = Presentr.alertViewController(title: "Chambre", body: self.descChambre!)
                
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
        Suite.action = { item in
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
                let alertController = Presentr.alertViewController(title: "Chambre", body: self.descSuite!)
                
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
        
        
        
        
        
        actionButton = ActionButton(attachedToView: self.view, items: [Chambre,Suite
            ])
        actionButton.action = { button in button.toggleMenu() }
        actionButton.setTitle("+", forState: UIControlState())
        
        actionButton.backgroundColor = UIColor(red: 238.0/255.0, green: 130.0/255.0, blue: 34.0/255.0, alpha:1.0)
        
        
        
        
        
    }
    
    
    
    var actualTable : String? = nil
    // to be conformed to the protocol
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print ("je suis dans : \(String(describing: actualTable))")
        //print("Value: \(Array[indexPath.row])")
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "GalleryImage") as! GalleryImage
        
        
        if (actualTable == "Chambre" && Reachability.isInternetAvailable()){
            
            
            switch indexPath.row {
            case 0:
                destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/PoolViewRoom"
                
                destination.TypeHebergement="http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/PoolViewRoom"
                
                navigationController?.pushViewController(destination, animated: true)
                //present(destination, animated: true, completion: nil)
                break
            case 1:
                destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/PartialOceanViewRoom"
                
                destination.TypeHebergement="http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/PartialOceanViewRoom"
                navigationController?.pushViewController(destination, animated: true)
                break
            case 2:
                destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/OceanViewRoom"
                
                destination.TypeHebergement="http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/OceanViewRoom"
                navigationController?.pushViewController(destination, animated: true)
                break
            case 3:
                navigationController?.pushViewController(destination, animated: true)
                destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/PrimeOceanViewRoom"
                destination.TypeHebergement="http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/PrimeOceanViewRoom"
                break
                
                
            default:
                print("nothing to do !!!")
            }
            
            
        }else{
          
            self.view.makeToast("No internet connection !")

            
    }
    
        if (actualTable == "Suite" && Reachability.isInternetAvailable())
        {
            switch indexPath.row {
            case 0:
                destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/OceanViewMazaganSuite"
                destination.TypeHebergement="http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/OceanViewMazaganSuite"
                navigationController?.pushViewController(destination, animated: true)
                break
            case 1:
                destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/PrimeOceanMazaganSuite"
                destination.TypeHebergement="http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/PrimeOceanMazaganSuite"
                navigationController?.pushViewController(destination, animated: true)
                break
            case 2:
                destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/ExecutiveSuite"
                destination.TypeHebergement="http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/ExecutiveSuite"
                navigationController?.pushViewController(destination, animated: true)
                break
            case 3:
                destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/AmbassadorSuite"
                destination.TypeHebergement="http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/AmbassadorSuite"
                navigationController?.pushViewController(destination, animated: true)
                break
                
            case 4:
                destination.toPass = "http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetPhoto/RoyalSuite"
                destination.TypeHebergement="http://beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/RoyalSuite"
                navigationController?.pushViewController(destination, animated: true)
                break
                
            default:
                print("nothing to do !!!")
            }
            
        }else{
            self.view.makeToast("No internet connection !")

        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (segmentedControl.currentSegment == 0){
            actualTable = "Chambre"
            print ("im in chambre")
            
            
            return 4
        }
        if (segmentedControl.currentSegment == 1){
            print ("im in suite")
            actualTable = "Suite"
            
            
            return 5
        }
        
        return 9
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.textLabel?.textColor = UIColor.blue
        
        if (segmentedControl.currentSegment == 0){
            
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Pool View Room"
                cell.imageView?.image = image1.image
                image1.frame = rect
            case 1:
                cell.textLabel?.text = "Partial Ocean View Room"
                image2.frame = rect
                
                cell.imageView?.image = image2.image
                
                
            case 2:
                cell.textLabel?.text = "Ocean View Room"
                image3.frame = rect
                
                cell.imageView?.image = image3.image
                
                
            case 3:
                cell.textLabel?.text = "Prime Ocean View Room"
                image4.frame = rect
                
                cell.imageView?.image = image4.image
                
                
            default:
                cell.textLabel?.text = "No Rows"
                
            }
            
        }
        if (segmentedControl.currentSegment == 1){
            imageView.frame = rect
            cell.imageView?.image = imageView.image
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Ocean View Mazagan Suite"
            case 1:
                cell.textLabel?.text = "Prime Ocean Mazagan Suite"
            case 2:
                cell.textLabel?.text = "Executive  Suite"
            case 3:
                cell.textLabel?.text = "Ambassadeur Suite"
            case 4:
                cell.textLabel?.text = "Royal Suite"
            default:
                cell.textLabel?.text = "No Rows"
                
            }
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Uncomment the following line to set the current segment programmatically.
        // segmentedControl.currentSegment = 1
    }
    
    
}

// MARK: - SJFluidSegmentedControl Data Source Methods

extension ViewControllerSegmented: SJFluidSegmentedControlDataSource {
    
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        return 3
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          titleForSegmentAtIndex index: Int) -> String? {
        
        if index == 0 {
            return "Chambre".uppercased()
        } else if index == 1 {
            return "Suite".uppercased()
        }
        return "Villa".uppercased()
    }
    
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
        
        let offset:CGFloat = UIScreen.main.bounds.size.width * CGFloat(toIndex - fromIndex);
        
        scrollView.contentOffset.x += offset
        
        //        self.segmentedControl(segmentedControl, didScrollWithXOffset:offset)
        
        print ("index is : \(fromIndex) \(toIndex)")
        self.myTableView?.reloadData()
        self.myTableView1?.reloadData()
        
        
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

extension ViewControllerSegmented: SJFluidSegmentedControlDelegate {
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didScrollWithXOffset offset: CGFloat) {
        
        print("Scrolling offset: \(offset)")
        
        //        scrollView.contentOffset.x += offset
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        
        
        
    }
    
    
    
}

