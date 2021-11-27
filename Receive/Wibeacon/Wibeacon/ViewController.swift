//
//  ViewController.swift
//  Wibeacon
//
//  Created by NaXin on 2019/10/28.
//  Copyright © 2019年 NaXin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BeaconScannerDelegate {

    @IBOutlet weak var textEdit: UITextView!
    @IBOutlet weak var add_btn: UIButton!
    @IBOutlet weak var pause_btn: UIButton!
    @IBOutlet weak var clear_btn: UIButton!
    @IBOutlet weak var share_btn: UIButton!
    @IBOutlet weak var clean_uuid_btn: UIButton!
    @IBOutlet weak var split_btn: UIButton!
    
    var running: Bool!
    var split_cnt: Int32!
    var beacon_scaner: BeaconScanner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.running = false
        self.split_cnt = 0
        
        // init display
        clear_btn.layer.borderWidth = 1.0
        clear_btn.layer.borderColor = UIColor.blue.cgColor
        clear_btn.layer.cornerRadius = 10
        pause_btn.layer.borderWidth = 1.0
        pause_btn.layer.borderColor = UIColor.blue.cgColor
        pause_btn.layer.cornerRadius = 10
        add_btn.layer.borderWidth = 1.0
        add_btn.layer.borderColor = UIColor.blue.cgColor
        add_btn.layer.cornerRadius = 10
        share_btn.layer.borderWidth = 1.0
        share_btn.layer.borderColor = UIColor.blue.cgColor
        share_btn.layer.cornerRadius = 10
        clean_uuid_btn.layer.borderWidth = 1.0
        clean_uuid_btn.layer.borderColor = UIColor.blue.cgColor
        clean_uuid_btn.layer.cornerRadius = 10
        split_btn.layer.borderWidth = 1.0
        split_btn.layer.borderColor = UIColor.blue.cgColor
        split_btn.layer.cornerRadius = 10
        textEdit.layer.borderWidth = 1.0
        textEdit.layer.borderColor = UIColor.blue.cgColor
        textEdit.layer.cornerRadius = 10
        textEdit.isEditable = false
        
        beacon_scaner = BeaconScanner()
        beacon_scaner.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        beacon_scaner.stopScanning()
    }
    
    func didFindBeacon(beaconScanner: BeaconScanner, info: String, log: String) {
        logtoDisplay(str: info)
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let handle = FileHandle(forWritingAtPath: appDelegate.logFilePath)
        handle?.seekToEndOfFile()
        handle?.write(log.data(using: String.Encoding.utf8)!)
    }
    
    ///
    ///         Click Action
    ///
    @IBAction func pause_click(_ sender: Any) {
        if (self.running) {
            // stop ranging
            beacon_scaner.stopScanning()
            self.pause_btn.setTitle("Resume", for: UIControl.State.normal)
            self.running = false
        }
        else {
            // resume ranging
            beacon_scaner.startScanning()
            self.pause_btn.setTitle("Pause", for: UIControl.State.normal)
            self.running = true
        }
    }
    
    @IBAction func clear_click(_ sender: Any) {
        textEdit.text = ""
        // let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        // appDelegate.forceCreate(file_path: appDelegate.logFilePath)
    }
    
    @IBAction func share_click(_ sender: Any) {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let fileURL = NSURL(fileURLWithPath: appDelegate.logFilePath)
        let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func clean_uuid_click(_ sender: Any) {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        appDelegate.uuidDict.removeAll()
    }
    
    @IBAction func split_click(_ sender: Any) {
        self.split_cnt += 1
        textEdit.text = ""
        let split_info = String(format: "[INFO] - Now collecting No.%d\n", self.split_cnt)
        let split_log = String(format: "No.%d\n", self.split_cnt)
        logtoDisplay(str: split_info)
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let handle = FileHandle(forWritingAtPath: appDelegate.logFilePath)
        handle?.seekToEndOfFile()
        handle?.write(split_log.data(using: String.Encoding.utf8)!)
    }
    
    func weakCreate(file_path: String) -> Bool {
        let fileManager: FileManager = FileManager.default
        let exist = fileManager.fileExists(atPath: file_path)
        if (exist) {
            return true
        }
        let createSuccess = fileManager.createFile(atPath: file_path, contents: nil, attributes: nil)
        return createSuccess as Bool
    }
    
    func logtoDisplay(str: String) {
        textEdit.insertText(str + "\n")
    }
    
    @IBAction func unwind_cancel(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwind_done(_ unwindSegue: UIStoryboardSegue) {
        if let id_str = (unwindSegue.source as! AddUUID).text_name.text, let uuid_str = (unwindSegue.source as! AddUUID).text_uuid.text {
            if let uuid = UUID(uuidString: uuid_str) {
                // need to do something
                logtoDisplay(str: "[INFO] - Added UUID successful!\n")
            }
            else {
                logtoDisplay(str: "[INFO] - Invalid UUID, Please check!")
            }
        }
    }
    
}

