@IsTest
public class JSON2Apex_Test {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'	\"accountStatus\" : \"enabled\",'+
		'	\"transactionDetails\": {'+
		'		\"properties\":{'+
		'			\"resourceId\": \"cb880508-78e9-11ea-bc55-0242ac130003\",'+
		'			\"name\": \"Supermarket\",'+
		'			\"balanceType\": \"expected\",'+
		'			\"amount\":{'+
		'				\"currency\":\"EUR\",'+
		'				\"amount\":\"5877.78\"'+
		'			},'+
		'			\"transactionDate\": \"2020-04-25T15:30:35.035Z\"'+
		'		}'+
		'	},'+
		'	\"accountTransactionList\":[{'+
		'		\"iban\":\"ES4700759339324669344918\",'+
		'		\"amount\":{'+
		'				\"currency\":\"EUR\",'+
		'				\"amount\":\"5877.78\"'+
		'		},'+
		'		\"currencyCode\":\"EUR\",'+
		'		\"transactionDate\":\"2020-04-25T15:30:35.035Z\",'+
		'		\"amountValue\":\"5877.78\",'+
		'		\"product\": \"current\"'+
		'	}]'+
		'}';
		JSON2Apex r = JSON2Apex.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex objJSON2Apex = new JSON2Apex(System.JSON.createParser(json));
		System.assert(objJSON2Apex != null);
		System.assert(objJSON2Apex.accountStatus == null);
		System.assert(objJSON2Apex.transactionDetails == null);
		System.assert(objJSON2Apex.accountTransactionList == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex.AccountTransactionList objAccountTransactionList = new JSON2Apex.AccountTransactionList(System.JSON.createParser(json));
		System.assert(objAccountTransactionList != null);
		System.assert(objAccountTransactionList.iban == null);
		System.assert(objAccountTransactionList.amount == null);
		System.assert(objAccountTransactionList.currencyCode == null);
		System.assert(objAccountTransactionList.transactionDate == null);
		System.assert(objAccountTransactionList.amountValue == null);
		System.assert(objAccountTransactionList.product == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex.Amount objAmount = new JSON2Apex.Amount(System.JSON.createParser(json));
		System.assert(objAmount != null);
		System.assert(objAmount.currency_Z == null);
		System.assert(objAmount.amount == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex.Properties objProperties = new JSON2Apex.Properties(System.JSON.createParser(json));
		System.assert(objProperties != null);
		System.assert(objProperties.resourceId == null);
		System.assert(objProperties.name == null);
		System.assert(objProperties.balanceType == null);
		System.assert(objProperties.amount == null);
		System.assert(objProperties.transactionDate == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex.TransactionDetails objTransactionDetails = new JSON2Apex.TransactionDetails(System.JSON.createParser(json));
		System.assert(objTransactionDetails != null);
		System.assert(objTransactionDetails.properties == null);
	}
}