//
//  QtibasListViewController.swift
//  iqtibasat qasira
//
//  Created by mac ventora on 26/1/2025.
//


import UIKit
import GoogleMobileAds

class QtibasListViewController: UIViewController , GADFullScreenContentDelegate {

    let request = GADRequest()
    private var interstitial: GADInterstitialAd?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadAdInter(code : UserDefaults.standard.string(forKey: "codeInterAd" ) ?? "0000")
        
    }
    

    
    func loadAdInter(code : String){
        GADInterstitialAd.load(withAdUnitID: code , request: request, completionHandler: { [self] ad, error in
                            if let error = error {
                              print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                              return
                            }
                            interstitial = ad
                            interstitial?.fullScreenContentDelegate = self
                            interstitial?.present(fromRootViewController: self)
                          }
        )
    }
    
    
    
}
