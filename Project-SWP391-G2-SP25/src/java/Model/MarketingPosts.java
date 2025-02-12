/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author Tùng Dương
 */
public class MarketingPosts {
    private int postID;
    private String title;
    private String content;
    private int author;
    private Date createDate;
    private String status;
    private String imageLink;

    public MarketingPosts() {
    }

    public MarketingPosts(int postID, String title, String content, int author, Date createDate, String status, String imageLink) {
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

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
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

    @Override
    public String toString() {
        return "MarketingPosts{" +
               "postID=" + postID +
               ", title='" + title + '\'' +
               ", content='" + content + '\'' +
               ", author=" + author +
               ", createDate='" + createDate + '\'' +
               ", status='" + status + '\'' +
               ", imageLink='" + imageLink + '\'' +
               '}';
    }

    public void setAuthor(String admin) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
