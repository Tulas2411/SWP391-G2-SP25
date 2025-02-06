/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Admin
 */

public class MarketingPost {
    private int id; // ID của bài viết
    private String title; // Tiêu đề
    private String content; // Nội dung
    private String author; // Tác giả
    private String createDate; // Ngày tạo
    private String status; // Trạng thái
    private String imageLink; // Đường dẫn hình ảnh

    // Constructor mặc định
    public MarketingPost() {}

    // Constructor có tham số
    public MarketingPost(int id, String title, String content, String author, String createDate, String status, String imageLink) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.author = author;
        this.createDate = createDate;
        this.status = status;
        this.imageLink = imageLink;
    }

    // Getter và Setter cho từng thuộc tính
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
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

    @Override
    public String toString() {
        return "MarketingPost{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", author='" + author + '\'' +
                ", createDate='" + createDate + '\'' +
                ", status='" + status + '\'' +
                ", imageLink='" + imageLink + '\'' +
                '}';
    }
}
