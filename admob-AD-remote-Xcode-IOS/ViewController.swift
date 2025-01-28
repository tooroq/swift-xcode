//
//  ViewController.swift
//  iqtibasat qasira
//
//  Created by mac ventora on 25/1/2025.
//

import GoogleMobileAds
import UIKit

class ViewController: UIViewController  {

    
    
    var bannerView: GADBannerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fetchDataJsonCode()
        
    }

    func fetchDataJsonCode() {
        // رابط JSON
        guard let url = URL(string: "https://tooroq.github.io/adsAppsIOS/qtibasat.json") else { return }
        // إنشاء طلب API
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // معالجة الخطأ
            if let error = error { return  }
            // التحقق من البيانات
            guard let data = data else { return }

            do {
                // فك تشفير JSON إلى الكائن المطلوب
                let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                   DispatchQueue.main.async {
                     
                       print("البيانات المستلمة: \(decodedResponse.app)")
                
                       UserDefaults.standard.setValue(decodedResponse.banner , forKey: "codeBannerAd" )
                       UserDefaults.standard.set(decodedResponse.inter , forKey: "codeInterAd" )
                       UserDefaults.standard.set(decodedResponse.vedio , forKey: "codeVedioAd" )
                       
                       self.banner(codebanner : decodedResponse.banner)
                       
                   }
                
            } catch {
                  print("خطأ في فك تشفير JSON: \(error.localizedDescription)")
            }
        }
        // بدء الطلب
        task.resume()
    }
    
    
    
    
    func banner(codebanner : String){
       
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = codebanner
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

    

    
}


// تعريف هيكل البيانات (Struct) للـ JSON
struct APIResponse: Decodable {
    let app: String
    let banner: String
    let inter: String
    let vedio: String
    let urlCheck: String
    let urlPIns: String
    let urlPSha: String
    let urlPYou: String
    let urlPFac: String
}
