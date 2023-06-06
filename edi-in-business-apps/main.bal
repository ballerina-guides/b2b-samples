import ballerina/http;
import ballerina/io;
import edi_in_business_apps.hmart;

http:Client salesEp = check new (url = "http://kwLogistics");

public function main() returns error? {
   string ediText = check io:fileReadString("inFolder/message.edi");
   hmart:HMartOrder hmartOrder = check hmart:fromEdiString(ediText);
   int totalQuantity = 0;
   foreach hmart:Items_Type item in hmartOrder.items {
       totalQuantity += item.quantity;
   }
   if totalQuantity > 100 {
       json response = check salesEp->/largeOrders.post(
           {salesOrder: hmartOrder, totalQuantity});
       io:println(response);
   } else {
       json response = check salesEp->/orders.post(
           {salesOrder: hmartOrder});
       io:println(response);
   }  
}