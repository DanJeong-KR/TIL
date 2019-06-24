//
//  ViewController.swift
//  SandboxDirectoryExample
//
//  Created by giftbot on 15/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  let fileManager = FileManager.default
  let bundle = Bundle.main
  
  var chartYears: [String] = []
  var songsChart: [String: [String: [String]]] = [:]
  
  
  // MARK: - [ Print directory ]
  
  @IBAction private func printBundleDirectory(_ sender: UIButton) {
    print("\n---------- [ BundlePath ] ----------")
    print(bundle.bundlePath)
    
    print("\n---------- [ Bundle InfoDictionary ] ----------")
    let info = bundle.infoDictionary!
    print("Bundle InfoDictionary : \(info)")
  }
  
  @IBAction private func printDocumentsDirectory(_ sender: UIButton) {
    print("\n---------- [ DocumentsPath ] ----------")
    let documentsUrl = FileManager.default.urls(
      for: .documentDirectory,
      in: .userDomainMask
      ).first!
    print(documentsUrl.path)
    
//    if let contents = try? fileManager.contentsOfDirectory(
//      at: documentsUrl, includingPropertiesForKeys: [], options: [.skipsHiddenFiles]
//      ) {
//      print(contents)
//    }
  }
  @IBAction private func printApplicationSupportDirectory(_ sender: UIButton) {
    print("\n---------- [ ApplicationSupportPath ] ----------")
//    let appSupportUrl = FileManager.default.urls(
//      for: <#directory#>,
//      in: .userDomainMask
//      ).first!
//    print(appSupportUrl.path)
    
    print("\n---------- [ ApplicationSupport Contents ] ----------")
//    if let contents = try? fileManager.contentsOfDirectory(
//      at: appSupportUrl, includingPropertiesForKeys: [], options: [.skipsHiddenFiles]
//      ) {
//      contents.forEach { print($0.lastPathComponent) }
//    }
    
    print("\n---------- [ ApplicationSupport Nested Dir Contents ] ----------")
  }
  
  @IBAction private func printCachesDirectory(_ sender: UIButton) {
    print("\n---------- [ printCachesPath ] ----------")
//    let cachesUrl = FileManager.default.urls(
//      for: <#directory#>,
//      in: .userDomainMask
//      ).first!
//    print(cachesUrl.path)
    
//    if let contents = try? fileManager.contentsOfDirectory(
//      at: cachesUrl, includingPropertiesForKeys: [], options: [.skipsHiddenFiles]
//      ) {
//      print(contents)
//    }
  }
  @IBAction private func printTemporaryDirectory(_ sender: UIButton) {
    print("\n---------- [ TemporaryPath ] ----------")
//    let tmpUrl = <#directory#>
//    print(tmpUrl.path)
    
//    if let contents = try? fileManager.contentsOfDirectory(
//      at: tmpUrl, includingPropertiesForKeys: [], options: [.skipsHiddenFiles]
//      ) {
//      print(contents)
//    }
  }
  
  
  
  // MARK: - [ File Handling ]
  
  @IBAction private func bundleFile(_ sender: UIButton) {
    print("\n---------- [ SongsChart in BundleContainer ] ----------")
  }
  
  
  @IBAction private func updateFileData(_ sender: Any) {
    print("\n---------- [ Update FileData ] ----------")
    
//    songsChart["Melon"]?["2016년"] = [
//      "TWICE (트와이스) - CHEER UP",
//      "여자친구 (GFRIEND) - 시간을 달려서 (Rough)",
//      "엠씨더맥스 - 어디에도",
//      "어반자카파 - 널 사랑하지 않아",
//      "다비치 - 이 사람",
//      "한동근 - 이 소설의 끝을 다시 써보려 해",
//      "지코 (ZICO) - 너는 나 나는 너",
//      "거미 - You Are My Everything",
//      "TWICE (트와이스) - OOH-AHH하게",
//      "이적 - 걱정말아요 그대"
//    ]
    
  }
  
  private func saveFileUrl() -> URL {
    return URL(string: "")!
  }
  
  
  @IBAction private func saveFile(_ sender: UIButton) {
    print("\n---------- [ Save File to ApplicationSupport ] ----------")
  }
  
  @IBAction private func loadFile(_ sender: UIButton) {
    print("\n---------- [ Load File from ApplicationSupport ] ----------")
  }
}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    return cell
  }
}


