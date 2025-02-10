/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Blog {
    private int blogID;
    private String cateID;
    private String title;
    private int author;
    private String image;
    private String briefInfor;
    private Date createDate;
    private String blogContent;
    private String status;
    private String thumbnail;
    private Boolean flag;
    private Date dateModified;
    private int numberOfAccess;

    public Blog() {
    }

    public Blog(int blogID, String cateID, String title, int author, String image, String briefInfor, Date createDate, String blogContent, String status, String thumbnail, Boolean flag, Date dateModified, int numberOfAccess) {
        this.blogID = blogID;
        this.cateID = cateID;
        this.title = title;
        this.author = author;
        this.image = image;
        this.briefInfor = briefInfor;
        this.createDate = createDate;
        this.blogContent = blogContent;
        this.status = status;
        this.thumbnail = thumbnail;
        this.flag = flag;
        this.dateModified = dateModified;
        this.numberOfAccess = numberOfAccess;
    }

    public int getBlogID() {
        return blogID;
    }

    public void setBlogID(int blogID) {
        this.blogID = blogID;
    }

    public String getCateID() {
        return cateID;
    }

    public void setCateID(String cateID) {
        this.cateID = cateID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getAuthor() {
        return author;
    }

    public void setAuthor(int author) {
        this.author = author;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getBriefInfor() {
        return briefInfor;
    }

    public void setBriefInfor(String briefInfor) {
        this.briefInfor = briefInfor;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getBlogContent() {
        return blogContent;
    }

    public void setBlogContent(String blogContent) {
        this.blogContent = blogContent;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public Boolean getFlag() {
        return flag;
    }

    public void setFlag(Boolean flag) {
        this.flag = flag;
    }

    public Date getDateModified() {
        return dateModified;
    }

    public void setDateModified(Date dateModified) {
        this.dateModified = dateModified;
    }

    public int getNumberOfAccess() {
        return numberOfAccess;
    }

    public void setNumberOfAccess(int numberOfAccess) {
        this.numberOfAccess = numberOfAccess;
    }
    
}
