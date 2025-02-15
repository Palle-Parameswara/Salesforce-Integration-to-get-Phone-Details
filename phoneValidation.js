import { LightningElement, api, track } from 'lwc';
import validatePhoneNumber from '@salesforce/apex/PhoneValidationController.validatePhoneNumber';

export default class PhoneValidation extends LightningElement {
    @api recordId; // This is the Contact record Id
    @track phoneDetails;
    @track error;
    @track isModalOpen = false; // Control modal visibility

    // Handle phone number validation
    handleValidate() {
        // Call the Apex method to validate the phone number for the provided Contact recordId
        validatePhoneNumber({ contactId: this.recordId })
            .then(result => {
                this.phoneDetails = result; // Store the result of phone validation
                this.isModalOpen = true; // Open the modal once data is retrieved
            })
            .catch(error => {
                this.error = error.body.message; // Handle error if the API call fails
            });
    }

    // Close the modal after displaying phone details
    handleCloseModal() {
        this.isModalOpen = false; // Close the modal by setting this to false
        this.phoneDetails = null; // Clear phone details
    }
}
