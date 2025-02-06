/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Tùng Dương
 */
public class Reply {
    private int replyID;
    private int reviewID;
    private String replyComment;
    private String replyDate;

    public Reply() {
    }

    public Reply(int replyID, int reviewID, String replyComment, String replyDate) {
        this.replyID = replyID;
        this.reviewID = reviewID;
        this.replyComment = replyComment;
        this.replyDate = replyDate;
    }

    public int getReplyID() {
        return replyID;
    }

    public void setReplyID(int replyID) {
        this.replyID = replyID;
    }

    public int getReviewID() {
        return reviewID;
    }

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
    }

    public String getReplyComment() {
        return replyComment;
    }

    public void setReplyComment(String replyComment) {
        this.replyComment = replyComment;
    }

    public String getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(String replyDate) {
        this.replyDate = replyDate;
    }
    
}
