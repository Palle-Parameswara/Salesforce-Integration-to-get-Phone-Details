public class PhoneValidationController {
    
    private static final String API_KEY = 'd90b7df724114ec59a326b81afca3e4e'; // Replace with your actual API key
    
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> validatePhoneNumber(String contactId) {
        // Retrieve the contact based on the given phoneNumber (Ensure phoneNumber is a valid Contact ID)
        Contact c = [SELECT Id, Phone FROM Contact WHERE Id = :contactId LIMIT 1];
        
        // Construct the full API endpoint using the Named Credential for base URL
       String endpoint = 'callout:Phone_Number_Validation/v1/?api_key=' + API_KEY + '&phone=' + EncodingUtil.urlEncode(c.Phone, 'UTF-8');

        System.debug('endpoint===>'+endpoint);
        
        // Make the HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);  // Using the Named Credential base URL and appending the phone number
        req.setMethod('GET');
        
        // Send the HTTP request
        Http http = new Http();
        HttpResponse res = http.send(req);
        System.debug('res===>'+res.getbody());
        // Handle the response
        if (res.getStatusCode() == 200) {
            // Parse the response body into a map and return it
            Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            
            return response;
            
        } else {
            // Handle error response from the API (non-200 status)
            throw new AuraHandledException('Error calling external service: ' + res.getStatusCode() + ' - ' + res.getBody());
        }
    }
}