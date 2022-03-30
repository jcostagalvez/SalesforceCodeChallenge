import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getInfoFromMock from '@salesforce/apex/CAP_show_Account_Controller.getInfoFromMock';
import ACCOUNT_ID from '@salesforce/schema/Account.AccountId__c';
const fields = [ACCOUNT_ID];

export default class Test extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields })
    account;
    //Variables
    transactions;
    error;
    transactionsDetails;
    amount;
    areDetailsVisible = false;

    get AcountMicroservice() {
        return getFieldValue(this.account.data, ACCOUNT_ID);
    }

    handleSearch() {
        getInfoFromMock({ accountId :this.recordId, accountIdMicroService:this.AcountMicroservice })
            .then((result) => {
                console.log('Success --->' );
                console.log(result);
                this.handleVariableFromMicroservice(result);
                this.error = undefined;
            })
            .catch((error) => {
                console.log('Error ---> ');
                console.log(error.message);
                this.error = error;
                this.transactions = undefined;
            });
    }

    handleVariableFromMicroservice(result){
        this.transactions = JSON.parse(result);
        const transaction = this.transactions.transactionDetails
        console.log('transaction --->' );
        console.log(transaction);
        this.transactionsDetails = transaction.properties;
        console.log('transactionsDetails --->' );
        console.log( this.transactionsDetails);
        this.amount = this.transactionsDetails.amount
        console.log('amount --->' );
        console.log(this.amount);
        this.areDetailsVisible = true;
    }
}