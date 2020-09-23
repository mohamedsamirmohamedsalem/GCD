//
//  AppDelegate.swift
//  RXSwift_Examples
//
//  Created by msalem on 2/18/20.
//  Copyright © 2020 msalem. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
         //simpleQueues()
        
       //  queuesWithQoS()
        
        
         //concurrentQueues()
         //if let queue = inactiveQueue {
         //   queue.activate()
        // }
         
        
       //  queueWithDelay()
        
        // fetchImage()
        
         useWorkItem()
    }
    
    
    
    func simpleQueues() {
        let queue = DispatchQueue(label: "com.samir.queue0")
        queue.async {
            for i in 0 ..< 10 {
                print("1 \(i)")
            }
        }
         ///Main queue
        for i in 100 ..< 110 {
                      print("2 \(i)")
                  }
    }
    
    
    func queuesWithQoS() {
        //              let queue1 = DispatchQueue(label: "com.samir.queue1", qos: DispatchQoS.userInitiated)
        //              let queue2 = DispatchQueue(label: "com.samir.queue2", qos: DispatchQoS.userInitiated)
        
        
        //                let queue1 = DispatchQueue(label: "com.samir.queue1", qos: DispatchQoS.userInitiated)
        //                let queue2 = DispatchQueue(label: "com.samir.queue2", qos: DispatchQoS.utility)
        //
//        let queue1 = DispatchQueue(label: "com.samir.queue1", qos: DispatchQoS.background)
//        let queue2 = DispatchQueue(label: "com.samir.queue2", qos: DispatchQoS.utility)
        let queue1 = DispatchQueue(label: "com.samir.queue1", qos: DispatchQoS.userInitiated)
        let queue2 = DispatchQueue(label: "com.samir.queue2", qos: DispatchQoS.utility)
        
        queue1.async {
            for i in 0 ..< 10 {
                print("1 \(i)")
            }
        }
        
        queue2.async {
            for i in 100 ..< 110 {
                print("2 \(i)")
            }
            
        }
       ///Main queue
        for i in 100..<110 {
            print("Ⓜ️", i)
        }
    }
    
    
    var inactiveQueue: DispatchQueue!
    
    func concurrentQueues() {
        let concurrentQueue = DispatchQueue(label: "com.appcoda.concurrentQueue", qos: .utility, attributes: .concurrent)
        
        
        concurrentQueue.async {
            for i in 0..<10 {
                print("1 : \(i)")
            }
        }
        concurrentQueue.async {
            for i in 0..<10 {
                print("2Ⓜ️ : \(i)")
            }
        }
        concurrentQueue.async {
            for i in 0..<10 {
                print("3 : \(i)")
            }
        }
        
    }
    
    
    func queueWithDelay() {

        let delayQueue = DispatchQueue(label: "com.appcoda.delayqueue", qos: .userInitiated)
        print(Date())
        let additionalTime: DispatchTimeInterval = .seconds(2)
        delayQueue.asyncAfter(deadline: .now() + additionalTime) {
            print(Date())
        }
//        delayQueue.asyncAfter(deadline: .now() + 2.0) {
//                   print(Date())
//               }
    }
    
    
    func fetchImage() {
        let imageURL: URL = URL(string: "http://www.appcoda.com/wp-content/uploads/2015/12/blog-logo-dark-400.png")!
     
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in
     
            if let data = imageData {
                print("Did download image data")
                
                    DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
                }
                
            }
        }).resume()
    }
    
    
    func useWorkItem() {
        var value = 10
     
        let workItem = DispatchWorkItem {
            value += 5
        }
     
    //    workItem.perform()
     
        let queue = DispatchQueue.global(qos: .utility)
     
        queue.async(execute: workItem)
     
        workItem.notify(queue: DispatchQueue.main) {
            print("value = ", value)
        }
    }
}

