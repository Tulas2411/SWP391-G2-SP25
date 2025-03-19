/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.List;

/**
 *
 * @author daoducdanh
 */
public class EmailTemplate {
    private Orders orders;
    private List<OrderDetails> orderDetailses;
    private Users users;
    
    public EmailTemplate(){
        
    }

    public EmailTemplate(Orders orders, List<OrderDetails> orderDetailses, Users users) {
        this.orders = orders;
        this.orderDetailses = orderDetailses;
        this.users = users;
    }
    
    
    
    
}
