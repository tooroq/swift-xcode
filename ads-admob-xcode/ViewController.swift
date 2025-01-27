//
//  ViewController.swift
//  iqtibasat qasira
//
//  Created by mac ventora on 25/1/2025.
//

import GoogleMobileAds
import UIKit

class ViewController: UIViewController , GADFullScreenContentDelegate {

    var bannerView: GADBannerView!
    let request = GADRequest()
    private var interstitial: GADInterstitialAd?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        banner()
        loadAdInter(code : String) 
    }


    func banner(){
       
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    // Ads Banner
    func addBannerViewToView(_ bannerView: GADBannerView) {
      bannerView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(bannerView)
      view.addConstraints(
        [NSLayoutConstraint(item: bannerView,
                            attribute: .bottom,
                            relatedBy: .equal,
                            toItem: view.safeAreaLayoutGuide,
                            attribute: .bottom,
                            multiplier: 1,
                            constant: -12),
         NSLayoutConstraint(item: bannerView,
                            attribute: .centerX,
                            relatedBy: .equal,
                            toItem: view,
                            attribute: .centerX,
                            multiplier: 1,
                            constant: 0)
        ])
     }

    


    func loadAdInter(){
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/1033173712" , request: request, completionHandler: { [self] ad, error in
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

