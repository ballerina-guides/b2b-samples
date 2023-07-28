import simple_edi_schema.hmart;
import ballerina/io;
public function main() returns error? {
   string ediText = check io:fileReadString("resources/in-message.edi");
   hmart:HMartOrder hmartOrder = check hmart:fromEdiString(ediText);
   foreach hmart:Items_Type item in hmartOrder.items {
       io:println(string `Item: ${item.name}, Quantity: ${item.quantity}`);
   }
   hmartOrder.items[0].quantity = 5;
   string outputEdi = check hmart:toEdiString(hmartOrder);
   io:println(outputEdi);
}