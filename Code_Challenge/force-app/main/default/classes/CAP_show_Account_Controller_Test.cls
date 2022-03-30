@isTest
public with sharing class CAP_show_Account_Controller_Test {
    
    @isTest
    public static void myTestMethod() {
      Account account = new Account();
      account.Name = 'Test Prueba';
      account.AccountId__c = 'cb880508-78e9-11ea-bc55-0242ac130003';
      Insert account;

      Test.startTest();
      CAP_show_Account_Controller.getInfoFromMock(account.Id, account.AccountId__c);
      Test.stopTest();

      System.assertNotEquals('',account.Adjustment__c);
    }
}
