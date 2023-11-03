import UIKit
import DesignSystem
import UtilityModule
import BookMarkDomainInterface
import Kingfisher

public final class BookMarkCollectionViewCell: UICollectionViewCell {
    
    public static let identifer = "BookMarkCollectionViewCell"
    

    
    public var imageView = UIImageView().then {
        $0.setRound([.allCorners], radius: 8)
        $0.image = DesignSystemAsset.Logo.tmpCard1.image
        $0.contentMode = .scaleAspectFill
    }
    
    public var title = AlleyLabel().then {
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }

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
        contentView.addSubviews(imageView,title)
    }
    
    private func makeConstrains() {
        imageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(GRID_WIDHT())
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.leading.equalTo(imageView)
            $0.right.equalToSuperview()
        }

    }
    
    public func update(model: MyBookMarkEntity) { // 변경 필요 (테스트용 함수임)
        self.imageView.kf.setImage(with: URL(string: model.recentImage))
        
        title.setMultipleAttributeText(text1: model.name, text2: " · \(model.count)개", color1: .black, color2: DesignSystemAsset.Grey.grey400.color, font1: .subtitle3, font2: .subtitle3)
        
        
    }
}



