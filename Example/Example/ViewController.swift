//
//  ViewController.swift
//  Example
//
//  Created by Frank.he on 2018/5/7.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit
import FHUD

struct FExample {
    let title: String
    let selector: Selector
    
    init(_ title: String, _ selector: Selector) {
        self.title = title
        self.selector = selector
    }
}

class ViewController: UIViewController {
    
    @objc func indicatorExample() {
        let _ = FHUD.show(.progress(mode: .default, title: nil), onView: self.view)
        
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(2)
            DispatchQueue.main.async {
                FHUD.hide(onView: self.view)
            }
        }
    }
    
    @objc func indicatorWithtextExample() {
        let _ = FHUD.show(.progress(mode: .default, title: "加载中..."), onView: self.view)
        
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(5)
            DispatchQueue.main.async {
                FHUD.hide(onView: self.view)
            }
        }
    }
    
    @objc func roundExample() {
        let hub = FHUD.show(.progress(mode: .round, title: nil), onView: self.view)
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            var progress = 0.0;
            while (progress < 1.0) {
                
                progress += 0.01;
                DispatchQueue.main.async {
                    hub.progress = progress;
                }
                usleep(50000);
            }
            
            DispatchQueue.main.async {
                FHUD.hide(onView: self.view)
            }
        }
    }

    @objc func roundWithtextExample() {
        let hub = FHUD.show(.progress(mode: .round, title: "loading..."), onView: self.view)
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            var progress = 0.0;
            while (progress < 1.0) {
                
                progress += 0.01;
                DispatchQueue.main.async {
                    hub.progress = progress;
                }
                usleep(50000);
            }
            
            DispatchQueue.main.async {
                FHUD.hide(onView: self.view)
            }
        }
    }
    
    @objc func gradientRotationExample() {
        let _ = FHUD.show(.progress(mode: .gradientRotation, title: nil), onView: self.view)
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(3)
            DispatchQueue.main.async {
                FHUD.hide(onView: self.view)
            }
        }
    }
    
    @objc func gradientRotationWithtextExample() {
        let hub = FHUD.show(.progress(mode: .gradientRotation, title: "loading..."), onView: self.view)
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(3)
            DispatchQueue.main.async {
                FHUD.hide(onView: self.view)
            }
        }
    }
    
    @objc func annularExample() {
        let hub = FHUD.show(.progress(mode: .annular, title: nil), onView: self.view)
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            var progress = 0.0;
            while (progress < 1.0) {
                
                progress += 0.01;
                DispatchQueue.main.async {
                    hub.progress = progress;
                }
                usleep(50000);
            }
            
            DispatchQueue.main.async {
                FHUD.hide(onView: self.view)
            }
        }
    }
    
    @objc func annularWithtextExample() {
        let hub = FHUD.show(.progress(mode: .annular, title: "loading..."), onView: self.view)
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            var progress = 0.0;
            while (progress < 1.0) {
                
                progress += 0.01;
                DispatchQueue.main.async {
                    hub.progress = progress;
                }
                usleep(50000);
            }
            
            DispatchQueue.main.async {
                FHUD.hide(onView: self.view)
            }
        }
    }

    @objc func zoomInOutCycleExample() {
        let _ = FHUD.show(.progress(mode: .zoomInOutCycle, title: nil), onView: self.view)
        
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(7)
            DispatchQueue.main.async {
                FHUD.hide(onView: self.view)
            }
        }
    }
    
    @objc func zoomInOutCycleWithtextExample() {
        let _ = FHUD.show(.progress(mode: .zoomInOutCycle, title: "加载中..."), onView: self.view)
        
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(7)
            DispatchQueue.main.async {
                FHUD.hide(onView: self.view)
            }
        }
    }
    
    @objc func imageAndTextExample() {
        let _ = FHUD.show(.flash(image: UIImage(named: "cross")!, title: "成功"), onView: self.view)
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(3)
            DispatchQueue.main.async {
                FHUD.hide(onView: self.view)
            }
        }
    }
    
    @objc func imageExample() {
        let _ = FHUD.show(.flash(image: UIImage(named: "checkmark")!, title: nil), onView: self.view)
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(3)
            DispatchQueue.main.async {
                FHUD.hide(onView: self.view)
            }
        }
    }
    
    @objc func promptExample() {
        let _ = FHUD.show(.prompt(title: "hello world"), onView: self.view)
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(3)
            DispatchQueue.main.async {
                FHUD.hide(onView: self.view)
            }
        }
    }
    
    let items = [FExample.init("indicator", #selector(indicatorExample)),
                 FExample.init("indicator With text", #selector(indicatorWithtextExample)),
                 FExample.init("zoomInOutCycle", #selector(zoomInOutCycleExample)),
                 FExample.init("zoomInOutCycle With text", #selector(zoomInOutCycleWithtextExample)),
                 FExample.init("gradientRotation", #selector(gradientRotationExample)),
                 FExample.init("gradientRotation With text", #selector(gradientRotationWithtextExample)),
                 FExample.init("round Progress", #selector(roundExample)),
                 FExample.init("round Progress With text", #selector(roundWithtextExample)),
                 FExample.init("annular Progress", #selector(annularExample)),
                 FExample.init("annular Progress With text", #selector(annularWithtextExample)),
                 FExample.init("image and text flash", #selector(imageAndTextExample)),
                 FExample.init("image falsh", #selector(imageExample)),
                 FExample.init("prompt", #selector(promptExample))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = items[indexPath.row].title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.perform(items[indexPath.row].selector)
    }
}

