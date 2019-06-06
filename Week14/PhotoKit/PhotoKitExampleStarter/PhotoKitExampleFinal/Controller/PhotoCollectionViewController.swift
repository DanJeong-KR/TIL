//
//  PhotoVC.swift
//  PhotoKitExampleFinal
//
//  Created by Wi on 04/06/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "PhotoCell"
private let reuseHeaderIndentifier = "PhotoHeader"

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    var images = [UIImage]()
    var assets = [PHAsset]()
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(PhotoCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseHeaderIndentifier)
        
        collectionView.backgroundColor = .white
        
        fetchPhotos()
        
        //(self.collectionViewLayout as! UICollectionViewFlowLayout).refer
    }
    
    // MARK: - UICollectionView
    

    // MARK: UICollectionViewFlowLayout
    // 헤더 크기 정하기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // MARK: UICollctionViewDatasource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell else {
            fatalError("Cell Type Error") // return 을 하지 않고 에러를 발생시키는 것
        }
        cell.photoImageView.image = images[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseHeaderIndentifier, for: indexPath) as? PhotoCell else { fatalError("header is not PhotoCell Type") }
        
        //header.photoImageView.image = selectedImage
        
        if let selectedImage = self.selectedImage {
            if let index = self.images.firstIndex(of: selectedImage) {
                let selectedAsset = self.assets[index]
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 20000, height: 20000)
                imageManager.requestImage(for: selectedAsset, targetSize: targetSize, contentMode: .default, options: nil) { (image, info) in
                    header.photoImageView.image = image
                }
            }
        }
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImage = images[indexPath.item]
        self.collectionView.reloadData()
    }
    
    
    
    
    
    // MARK: - Photos func
    
    
    func fetchPhotos(){
        
        // 옵션 만들기
        let options = PHFetchOptions()
        // 사진 몇개까지 가져올지
        options.fetchLimit = 30 // 30 개만 가져온다
        
        // 정렬방식 , key 부분은 PHFetchOptions 문서에 지원하는 key 문자열 나온다.
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        // 정렬 지정하기
        options.sortDescriptors = [sortDescriptor]
        
        DispatchQueue.global(qos: .background).async {
            // 사진 에셋 가져오기
            let allPhoto = PHAsset.fetchAssets(with: .image, options: options )
            
            
            // 에셋에 대해서만 반복문 돌게 해주는 함수
            allPhoto.enumerateObjects { (asset, count, stop) in
                // 이미지 매니저
                let imageManager = PHImageManager.default()
                
                // 사진 사이즈
                let targetSize = CGSize(width: 200, height: 200)
                
                // 이미지 요청할 때 옵션
                let options = PHImageRequestOptions()
                
                // 이미지를 동기적으로, 혹은 비동기적으로 가져올 것인지
                options.isSynchronous = true
                
                // 이미지 요청
                // 반복문에서 들어오는 asset  하나씩
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    if let image = image {
                        
                        //image 추가하기
                        self.images.append(image)
                        
                        // select 할 때 더 큰 이미지를 요청할 용도
                        self.assets.append(asset)
                        
                        if self.selectedImage == nil {
                            self.selectedImage = image
                        }
                        
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                        print("\(count) reload")
                    }
                })
            }
        }
        
        
    }
    
}
