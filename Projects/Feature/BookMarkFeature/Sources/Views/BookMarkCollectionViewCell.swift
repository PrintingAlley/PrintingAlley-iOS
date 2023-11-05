import UIKit
import DesignSystem
import UtilityModule
import BookMarkDomainInterface
import Kingfisher


protocol BookMarkCollectionViewCellDelegate: AnyObject {
    func tapBookMark(id: Int)
}

public final class BookMarkCollectionViewCell: UICollectionViewCell {
    
    public static let identifer = "BookMarkCollectionViewCell"
    

    
    lazy var imageView = UIImageView().then {
        $0.setRound([.allCorners], radius: 8)
        $0.image = DesignSystemAsset.Logo.tmpCard1.image
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var whiteEmptyView: UIView = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.4)
        $0.setRound([.allCorners], radius: 8)
    }
    
    lazy var button: UIButton = UIButton().then {
        $0.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    public var title = AlleyLabel().then {
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }
    
    
    weak var delegate: BookMarkCollectionViewCellDelegate?
    var model: MyBookMarkEntity!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI 관련 함수
extension BookMarkCollectionViewCell {
    
    private func addSubviews() {
        contentView.addSubviews(imageView,title,whiteEmptyView)
        whiteEmptyView.addSubviews(button)
        
    }
    
    private func makeConstrains() {
        imageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(GRID_WIDHT())
        }
        
        whiteEmptyView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(GRID_WIDHT())
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.leading.equalTo(imageView)
            $0.right.equalToSuperview()
        }
        
        
        button.snp.makeConstraints {
            $0.width.height.equalTo(64)
            $0.center.equalToSuperview()
        }

    }
    
    public func update(model: MyBookMarkEntity,isEditing: Bool) { 
        
        self.model = model
        
        self.imageView.kf.setImage(with: URL(string: model.recentImage),placeholder: DesignSystemAsset.PlaceHolder.largePH.image)
        
        title.setMultipleAttributeText(text1: model.name, text2: " · \(model.count)개", color1: .black, color2: DesignSystemAsset.Grey.grey400.color, font1: .subtitle3, font2: .subtitle3)
        
        
        whiteEmptyView.isHidden = !isEditing
        button.setImage(model.isSelected == true ? DesignSystemAsset.Icon.check.image : DesignSystemAsset.Icon.unCheck.image, for: .normal)
        
        
        
    }
    
    @objc func tapButton() {
        delegate?.tapBookMark(id: model.id)
    }
}



