//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Julio Leonardo Aguilar Colon on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var favorited:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    
    
    
//    ADDED BY ME
    @IBAction func retweet(_ sender: Any) {
        let tobeRetweeted = !retweeted
        if(tobeRetweeted){
        TwitterAPICaller.client?.reTweet(tweetId: tweetId, success: {
            self.setRetweeted(isRetweeted: true)
        }, failure: { (Error) in
            print("Error is retweeting: \(Error)")
        })}
            else{
               TwitterAPICaller.client?.unreTweet(tweetId: tweetId, success: {
                   self.setRetweeted(isRetweeted: false)
               }, failure: { (Error) in
                   print("UnRetweet did not succeed: \(Error)")
               })
            }
    }
    
    
    func setRetweeted(isRetweeted:Bool){
        if(isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
//            retweetButton.isEnabled = false
        }else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
//            retweetButton.isEnabled = true
        }
    }

    
    func setFavorite(isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if(tobeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: true)
            }, failure: { (Error) in
                print("Favorite did not succeed: \(Error)")
            })
        } else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: false)
            }, failure: { (Error) in
                print("Unfavorite did not succeed: \(Error)")
            })
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
