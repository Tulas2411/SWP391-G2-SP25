/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Tùng Dương
 */
public class MarketingPosts {
    private int postID;
    private String title;
    private String content;
    private int author;
    private String createDate;
    private String status;
    private String imageLink;

    public MarketingPosts() {
    }

    public MarketingPosts(int postID, String title, String content, int author, String createDate, String status, String imageLink) {
        this.postID = postID;
        this.title = title;
        this.content = content;
        this.author = author;
        this.createDate = createDate;
        this.status = status;
        this.imageLink = imageLink;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getAuthor() {
        return author;
    }

    public void setAuthor(int author) {
        this.author = author;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImageLink() {
        return imageLink;
    }

    public void setImageLink(String imageLink) {
        this.imageLink = imageLink;
    }
    
}
