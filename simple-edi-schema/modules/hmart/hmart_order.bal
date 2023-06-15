
import ballerina/edi;

public function fromEdiString(string ediText) returns HMartOrder|error {
    edi:EdiSchema ediSchema = check edi:getSchema(schemaJson);
    json dataJson = check edi:fromEdiString(ediText, ediSchema);
    return dataJson.cloneWithType();
}

public function toEdiString(HMartOrder data) returns string|error {
    edi:EdiSchema ediSchema = check edi:getSchema(schemaJson);
    return edi:toEdiString(data, ediSchema);    
}

public type Header_Type record {|
   string code?;
   string orderId?;
   string organization?;
   string date?;
|};

public type Items_Type record {|
   string code?;
   string name;
   int quantity;
|};

public type HMartOrder record {|
   Header_Type? header?;
   Items_Type[] items = [];
|};



json schemaJson = {"name":"HMartOrder", "delimiters":{"segment":"~", "field":"*", "component":":", "repetition":"^"}, "segments":[{"code":"HDR", "tag":"header", "fields":[{"tag":"code"}, {"tag":"orderId"}, {"tag":"organization"}, {"tag":"date"}]}, {"code":"ITM", "tag":"items", "minOccurances":1, "maxOccurances":-1, "fields":[{"tag":"code"}, {"tag":"name", "required":true}, {"tag":"quantity", "dataType":"int", "required":true}]}]};
    