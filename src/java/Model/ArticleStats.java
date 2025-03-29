/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author daoducdanh
 */
public class ArticleStats {
    private String title;
    private int numberOfAccess;

    public ArticleStats(String title, int numberOfAccess) {
        this.title = title;
        this.numberOfAccess = numberOfAccess;
    }

    public String getTitle() { return title; }
    public int getNumberOfAccess() { return numberOfAccess; }
}
