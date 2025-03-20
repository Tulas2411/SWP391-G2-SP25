/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.text.DecimalFormat;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 *
 * @author daoducdanh
 */
public class EmailTemplate {
    private Orders orders;
    private List<OrderDetailWithProduct> detailWithProducts;
    private Users users;
    private final DecimalFormat decimalFormat = new DecimalFormat("#,### VND");
    private final DateTimeFormatter dateTimeFormat = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
    
    public EmailTemplate(){
        
    }

    public EmailTemplate(Orders orders, List<OrderDetailWithProduct> detailWithProducts, Users users) {
        this.orders = orders;
        this.detailWithProducts = detailWithProducts;
        this.users = users;
    }
    
    public String getTemplate(){
        String body = "";
        body += "<div marginwidth=\"0\" marginheight=\"0\"\n" +
                "    style=\"font-size:13px;line-height:24px!important;font-family:arial;background:#eee;padding:5px\">\n" +
                "    <center>\n" +
                "      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"\n" +
                "        style=\"font-family:arial;max-width:600px;color:#333333;text-align:center;border-bottom-width:2px;border-bottom-style:solid;border-bottom-color:#c9c9c9;border-top-left-radius:5px;border-top-right-radius:5px;border-top-width:5px;border-top-style:solid;border-top-color:#1775bc;margin-top:50px;background-image:initial;background-size:initial;background-origin:initial;background-clip:initial;background-position:initial;background-repeat:initial;background:#fff\">\n" +
                "        <tbody>\n" +
                "          <tr>\n" +
                "            <td align=\"left\" style=\"padding:20px;line-height:24px\">\n" +
                "              <p>Xin chào <b>" +users.getFirstName() + " " + users.getLastName() + "</b>,</p>";
        body += "<p>Cảm ơn quý khách đã mua hàng tại shop của chúng tôi!</p>\n" +
                "              <table width=\"100%\" style=\"padding:10px\">\n" +
                "                <tbody>\n" +
                "                  <tr>\n" +
                "                    <td width=\"200px\">Sản phẩm</td>\n" +
                "                    <td>Số lượng</td>\n" +
                "                    <td>Tổng</td>\n" +
                "                    <td>Đánh giá</td>\n" +
                "                  </tr>";
        for(OrderDetailWithProduct od : detailWithProducts){
            Products p = od.getProducts();
            OrderDetails details = od.getOrderDetails();
            body += "<tr>\n" +
                    "                    <td width=\"200px\">\n" +
                    "                      <p>"+p.getProductName()+"</p>\n" +
                    "                    </td>\n" +
                    "                    <td>"+details.getQuantity()+"</td>\n" +
                    "                    <td>"+decimalFormat.format(details.getPrice())+"</td>\n" +
                    "                    <td><a href='http://localhost:8080/Project-SWP391-G2-SP25/ProductDetailController?id="+ p.getProductID()+"&user=" + users.getUserID() +"'>Đánh giá</a></td>\n" +
                    "                  </tr>";
        }
        body += "<tr>\n" +
                "                    <td colspan=\"4\">\n" +
                "                      <hr>\n" +
                "                    </td>\n" +
                "                  </tr>\n" +
                "                  <tr>\n" +
                "                    <td colspan=\"2\">Tổng tiền</td>\n" +
                "                    <td colspan=\"2\">"+decimalFormat.format(orders.getTotalAmount())+"</td>\n" +
                "                  </tr>\n" +
                "                </tbody>\n" +
                "              </table>\n" +
                "              <table width=\"100%\" style=\"padding:10px\">\n" +
                "                <tbody>";
        body +=
                "<tr>\n" +
                "                    <td>Địa chỉ</td>\n" +
                "                    <td>\n" +
                "                      <p>"+users.getFirstName() + " " + users.getLastName()+"</p>\n" +
                "                      <p>"+orders.getDeliveryAddress()+"</p>\n" +
                "                      <p>"+users.getPhoneNumber()+"</p>\n" +
                "                    </td>\n" +
                "                  </tr>\n" +
                "                </tbody>\n" +
                "              </table>\n" +
                "            </td>\n" +
                "          </tr>\n" +
                "        </tbody>\n" +
                "      </table>\n" +
                "    </center>\n" +
                "  </div>";
        return body;
    }
    
    
    
    
}
