public with sharing class CAP_show_Account_Controller {
    @AuraEnabled
    public Static String getInfoFromMock(String accountId, String accountIdMicroService){
        System.debug(CAP_Info_Mock.getMockAccount());
        Map<String,Object> mapJsonParsed =(Map<String,Object> ) JSON.deserializeUntyped(CAP_Info_Mock.getMockAccount());
        System.debug('CAP_show_Account_Controller - getInfoFromMock - mapJsonParsed ' + mapJsonParsed);
        Map<String,Object> mapTransactionDetails = ( Map<String,Object>) mapJsonParsed.get('transactionDetails');
        System.debug('CAP_show_Account_Controller - getInfoFromMock - mapTransactionDetails ' + mapTransactionDetails);
        Map<String,Object> mapProperties = ( Map<String,Object>) mapTransactionDetails.get('properties');
        System.debug('CAP_show_Account_Controller - getInfoFromMock - mapProperties ' + mapProperties);
        Map<String,Object> mapAmount = ( Map<String,Object>) mapProperties.get('amount');
        System.debug('CAP_show_Account_Controller - getInfoFromMock - mapAmount ' + mapAmount);
        updateAccount(accountId, mapAmount);
        return CAP_Info_Mock.getMockAccount();
    }

    Public Static void updateAccount(String accountId, Map<String,Object> mapAmount){
        Account accountToUpdate = [ SELECT Id, Adjustment__c
                                    FROM Account
                                    WHERE Id =: accountId
                                    LIMIT 1];
        String amountString = (String) mapAmount.get('amount');
        Decimal amount = decimal.valueOf(amountString);

        if( (accountToUpdate.Adjustment__c == null ||  accountToUpdate.Adjustment__c == 'CLOSED') && amount > 1000){
            accountToUpdate.Adjustment__c = 'CLOSED';
        }else if((accountToUpdate.Adjustment__c == null ||  accountToUpdate.Adjustment__c == 'CLOSED') && amount <= 1000){
            accountToUpdate.Adjustment__c = 'IN_PROGRESS';
        }

        try {
            update accountToUpdate;
        } catch (Exception e) {
            System.debug('CAP_show_Account_Controller');
        }
    }
}
