import UIKit

extension UIImageView {
    
    func loadImageUsingCacheWithURL(
        urlString: String,
        completion: (() -> Void)? = nil
    ) {

        let imageCache = NSCache<AnyObject, AnyObject>()

        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let downloadImage = UIImage(data: data!) {
                    imageCache.setObject(downloadImage, forKey: urlString as AnyObject)
                    self.image = downloadImage
                    completion?()
                }
            }
        }).resume()
    }
    
}
