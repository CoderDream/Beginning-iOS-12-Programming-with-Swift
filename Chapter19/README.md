

if let restaurantImage  = restaurants[indexPath.row].image {
    cell.thumbnailImageView.image = UIImage(data: restaurantImage as Data)
}