//
//  ViewController.swift
//  MazaganShowCase
//
//  Created by Nabil Alaoui on 2/11/17.
//  Copyright © 2017 B4E. All rights reserved.
//

import UIKit
import SideMenu


class ViewController: UIViewController {
    

    fileprivate var selectedIndex = 0
    fileprivate var transitionPoint: CGPoint!
    fileprivate var contentType: ContentType = .Music
    fileprivate var navigator: UINavigationController!
    
    lazy fileprivate var menuAnimator : MenuTransitionAnimator! = MenuTransitionAnimator(mode: .presentation, shouldPassEventsOutsideMenu: false) { [unowned self] in
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch (segue.identifier, segue.destination) {
        case (.some("presentMenu"), let menu as MenuViewController):
            
            print("presentMenu")
            menu.selectedItem = selectedIndex
            menu.delegate = self
            menu.transitioningDelegate = self
            menu.modalPresentationStyle = .custom
        case (.some("embedNavigator"), let navigator as UINavigationController):
            
            print("embedNavigator")
            self.navigator = navigator
            self.navigator.delegate = self
        default:
            print("default")
            super.prepare(for: segue, sender: sender)
        }
    }
    
   
}

    extension ViewController: MenuViewControllerDelegate {
        
        func menu(_: MenuViewController, didSelectItemAt index: Int, at point: CGPoint) {
            contentType = !contentType
            transitionPoint = point
            selectedIndex = index
            
            let content = storyboard!.instantiateViewController(withIdentifier: "Content") as! ContentViewController
            content.type = contentType
            navigator.setViewControllers([content], animated: true)
            
            
            if (index == 0){
                let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeController") as! HomePageController
                navigator.pushViewController(nextViewController, animated: true)
                print("passer le poush Home Page")


            }
        
            
            if (index == 1){
            
                
                let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SegmentedController") as! ViewControllerSegmented
                
                
                navigator.pushViewController(nextViewController, animated: true)
                
                print("passer le poush Hebergement")
                
            }
            
            if (index == 2){
                
                let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RestaurationID") as! RestaurationView
                
                
                navigator.pushViewController(nextViewController, animated: true)
                
                print("Restauration")

                print("test de menu clicked 2")
                
                
            }
            
            if (index == 3){
                let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GolfControllerID") as! GolfController
                
                
                navigator.pushViewController(nextViewController, animated: true)
                
                print("Restauration")

                
                                print("test de menu clicked 3)")
                
                
            }
            if (index == 4){
                
                let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpaControllerID") as! SpaController
                
                
                navigator.pushViewController(nextViewController, animated: true)
                
                print("Restauration")
                
                
                print("test de menu clicked 3)")
                
                print("test de menu clicked : 6)")
                
                
            }

            if (index == 5){
                
                let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EnfantControllerID") as! EnfantController
                
                
                navigator.pushViewController(nextViewController, animated: true)
                
                print("Restauration")
                
                
                print("test de menu clicked 3)")

                print("test de menu clicked : 4)")
                
                
            }
            
            if (index == 6){
                
                let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActiviteControllerID") as! ActiviteController
                
                
                navigator.pushViewController(nextViewController, animated: true)
                
                print("Restauration")
                
                
                print("test de menu clicked 3)")

                print("test de menu clicked : 5)")
                
                
            }
            
            
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        func menuDidCancel(_: MenuViewController) {
            dismiss(animated: true, completion: nil)
        }
    }
    
    extension ViewController: UINavigationControllerDelegate {
        
        func navigationController(_: UINavigationController, animationControllerFor _: UINavigationControllerOperation,
                                  from _: UIViewController, to _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            
            if let transitionPoint = transitionPoint {
                return CircularRevealTransitionAnimator(center: transitionPoint)
            }
            return nil
        }
    }
    
    extension ViewController: UIViewControllerTransitioningDelegate {
        
        func animationController(forPresented presented: UIViewController, presenting _: UIViewController,
                                 source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return menuAnimator
        }
        
        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return MenuTransitionAnimator(mode: .dismissal)
        }
}


