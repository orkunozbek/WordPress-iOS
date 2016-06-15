import Foundation
import UIKit


/// Displays an Image with a capped size, defined by the maximumSize property.
///
class MediaView : UIView
{
    // MARK: - Properties

    /// Defines the maximum size that this view might occupy.
    ///
    var maximumSize = CGSizeMake(90, 90) {
        didSet {
            refreshContentSize()
        }
    }

    /// The image that should be displayed
    ///
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            refreshContentSize()
        }
    }

    /// Internal imageView Instance
    ///
    private let imageView = UIImageView()

    /// Internal activityIndicator Instance
    ///
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)



    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }



    // MARK: - Public Methods

    /// Displays a spinner at the center of this view, and dims the imageView
    ///
    func startSpinner() {
        activityIndicatorView.startAnimating()
        imageView.alpha = Constants.alphaDimming
    }

    /// Stops the spinner, and restores the original alpha
    ///
    func stopSpinner() {
        activityIndicatorView.stopAnimating()
        imageView.alpha = Constants.alphaFull
    }



    // MARK: - Private Helpers

    private func setupSubviews() {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        imageView.leadingAnchor.constraintEqualToAnchor(leadingAnchor).active = true
        imageView.trailingAnchor.constraintEqualToAnchor(trailingAnchor).active = true
        imageView.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        imageView.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true

        addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        activityIndicatorView.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
    }

    private func refreshContentSize() {
        let targetSize = (image != nil) ? maximumSize : CGSizeZero
        widthAnchor.constraintEqualToConstant(targetSize.width).active = true
        heightAnchor.constraintEqualToConstant(targetSize.height).active = true
    }


    // MARK: - Private Enums

    private enum Constants {
        static let alphaDimming = CGFloat(0.3)
        static let alphaFull = CGFloat(1.0)
    }
}
