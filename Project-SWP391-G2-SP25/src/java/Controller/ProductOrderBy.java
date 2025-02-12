/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

/**
 *
 * @author Legion
 */
public enum ProductOrderBy {

    LATEST("CreateAt DESC", "Mới nhất"),
    PRICE_ASCEND("price asc", "Giá tăng dần"),
    PRICE_DESCEND("price desc", "Giá giảm dần");
    private String value;
    private String label;

    private ProductOrderBy(String value, String label) {
        this.value = value;
        this.label = label;
    }

    public String getValue() {
        return value;
    }

    public String getLabel() {
        return label;
    }

}
