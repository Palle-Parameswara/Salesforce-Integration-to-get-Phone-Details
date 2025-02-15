# Salesforce-Integration-to-get-Phone-Details

External website used: https://app.abstractapi.com/api/phone-validation/tester

Steps to Set Up Phone Number Validation Using Flow and External Services
Step 1: Create a Permission Set
The first step is to ensure that your user has the necessary permissions to access the integration via the Flow.

Create a Permission Set:

Go to Setup → Permission Sets → New.
Name the Permission Set, e.g., PhoneValidation_PermissionSet.
Under System Permissions, ensure the user has permission to use external services and run flows.
Add the External Credential (that you will set up later) to this permission set.
Assign Permission Set to User:

Go to the User record and assign the PhoneValidation_PermissionSet permission set to your user.

Step 2: Set Up External Credentials
Create External Credential:

Go to Setup → Named Credentials -> External Credentials → New.
Fill in the details:
Label: Phone Validation
Name: Phone_Validation
Authentication Protocol: Custom.
Managed Package Access: Leave as None.
Created By Namespace: Leave blank.
Related Named Credentials: This will be associated when creating the Named Credential.
Navigation Mode: Label.
Create Principal for External Credential:

In the Principals section, create a Principal Name:
Principal Name: PhoneNumberValidationPrincipal
Sequence Number: 0.
Authentication Status: Set to Unknown.
You will need to add a principal to associate with the Named Credential in the next step.
![image](https://github.com/user-attachments/assets/d428e8e6-a040-468b-90e0-12c980e7f701)


Step 3: Create Named Credential
Create a Named Credential:
Go to Setup → Named Credentials → New.

Fill in the details:

Label: Phone Number Validation
Name: Phone_Number_Validation
URL: https://phonevalidation.abstractapi.com/v1/phone
Principal: Choose the Principal you created earlier (PhoneNumberValidationPrincipal).
Authentication Protocol: Select Custom.
Authentication Type: None (if Abstract API doesn’t require authentication headers, the key is passed in the request itself).
Click Save.
![image](https://github.com/user-attachments/assets/2edfa7fd-9c91-49f0-9397-50edd01da8cb)


Step 4: Create an External Service for Phone Validation
Create an External Service:

Go to Setup → External Services.
Click New and select Named Credential.
Choose the Named Credential Phone_Number_Validation you created earlier.
This will generate an External Service based on the Abstract API.
Define Service Actions:

The External Service will create service actions based on the API you are integrating with (e.g., PhoneDetails.Phone Details).
Ensure that the phone number validation action (PhoneDetails.Phone Details) is available as an action in the external service.

![image](https://github.com/user-attachments/assets/31a2a884-a4f6-4ca2-b041-c7953bcc410b)
![image](https://github.com/user-attachments/assets/04e9620e-3687-4e23-a80e-7d58693173cb)
![image](https://github.com/user-attachments/assets/e6dfc043-101a-46f5-92b7-d2ca41f9f5d8)



Step 5: Create a Flow to Use the External Service
Create a Screen Flow:

Go to Setup → Flows → New Flow.
Select Screen Flow.
Add Screen Element to Capture Phone Number:

Add a Screen element.
Add a Phone input field (use the standard phone component in the flow) to allow the user to input the phone number.
Set the phone field as Required.
Add External Service Action to Call API:

After the Phone screen, add an Action element.
In the Action type, choose External Service.
Select the PhoneDetails.Phone Details action (this is the action defined in the external service based on Abstract API).
Map the phone number input from the screen to the phone input parameter in the external service.
Pass any additional parameters like the API key if required (this may be passed from the flow or configured in the external service setup).
Handle API Response:

Use a Decision element to check the response code from the API. You should check for a success code (e.g., 200) to ensure the API call succeeded.
Add connectors based on the result:
If successful (e.g., response code 200), proceed to the next screen to display the phone details.
If unsuccessful, show an error screen.
Display the Phone Details:

Add another Screen element to display the details of the phone number (validation status, location, country, carrier, etc.).
You can use the Display Text component to show the details returned from the PhoneDetails.Phone Details action.
Example of dynamic fields:
![image](https://github.com/user-attachments/assets/dcfe4798-f9c0-4cf3-a1e7-ce083e889bf5)
![image](https://github.com/user-attachments/assets/6219de53-b6d2-4f43-8902-4da3b34f6641)
![image](https://github.com/user-attachments/assets/0e4af6b2-7820-40ee-9f00-571fe860fe0c)
![image](https://github.com/user-attachments/assets/70c79b92-ae3d-46bc-9ffe-d7422a15fb3e)
![image](https://github.com/user-attachments/assets/8e073071-c70d-4e58-a4ea-5b5fc9e16ef9)
![image](https://github.com/user-attachments/assets/cebe6a1c-6c50-44ae-baf9-b8a7f097f30d)


Phone Number: {!Phone_number_details.phone}
Validation Status: {!Phone_number_details.valid}
Location: {!Phone_number_details.location}
Country: {!Phone_number_details.country.name}
Carrier: {!Phone_number_details.carrier}
Save and Activate the Flow:

Save your flow and activate it.
Step 6: Add the Flow to a Lightning Page
Go to Lightning App Builder:
Go to Setup → App Builder.
Select Home Page or a Record Page where you want to add the Flow.
Add the Flow component to the page layout.
Select the flow you created (e.g., Phone Details Flow).
Save and Activate the Page:
Save the page layout and activate it for users.
![image](https://github.com/user-attachments/assets/0c0aacbd-5610-441f-b018-7f37f4ffc869)


Step 1: Create an Apex Class to Call the Integration
We will create an Apex class that integrates with the external service (Abstract API) to validate the phone number.
PhoneValidationController

Please replace the api key


Step 2: Create a Lightning Web Component (LWC) to Handle the Popup
The LWC will display the popup with the phone details once the button is clicked. It will communicate with the Apex controller to fetch phone details.

Create the LWC Component:
phoneValidation.html
phoneValidation.js
phoneValidation.css
phoneValidation.js-meta.xml

Step 3: Create a Quick Action on the Contact Page
Go to Setup → Object Manager → Contact.
In the left sidebar, under Buttons, Links, and Actions, click New Action.
Choose Action Type: Lightning Component.
Set the following:
Action Name: Validate_Phone
Label: Validate Phone
Lightning Component: Select c:phoneValidation (the component you just created).
Save the action.

Step 4: Add the Quick Action to the Contact Page Layout
Go to Contact Page Layout.
In the Lightning App Builder, drag and drop the Quick Action (Validate Phone) to the Contact Layout.
Save and Activate the page layout.

Step 5: Test the Button and Popup
Go to a Contact record.
You should see the Validate Phone button.
Click the button, and the popup will appear showing the phone validation details from Abstract API.

References:
https://www.youtube.com/watch?v=sE6MX8vz1Y0
