public class JSON2Apex {

	public String accountStatus {get;set;} 
	public TransactionDetails transactionDetails {get;set;} 
	public List<AccountTransactionList> accountTransactionList {get;set;} 

	public JSON2Apex(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'accountStatus') {
						accountStatus = parser.getText();
					} else if (text == 'transactionDetails') {
						transactionDetails = new TransactionDetails(parser);
					} else if (text == 'accountTransactionList') {
						accountTransactionList = arrayOfAccountTransactionList(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class AccountTransactionList {
		public String iban {get;set;} 
		public Amount amount {get;set;} 
		public String currencyCode {get;set;} 
		public String transactionDate {get;set;} 
		public String amountValue {get;set;} 
		public String product {get;set;} 

		public AccountTransactionList(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'iban') {
							iban = parser.getText();
						} else if (text == 'amount') {
							amount = new Amount(parser);
						} else if (text == 'currencyCode') {
							currencyCode = parser.getText();
						} else if (text == 'transactionDate') {
							transactionDate = parser.getText();
						} else if (text == 'amountValue') {
							amountValue = parser.getText();
						} else if (text == 'product') {
							product = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'AccountTransactionList consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Amount {
		public String currency_Z {get;set;} // in json: currency
		public String amount {get;set;} 

		public Amount(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'currency') {
							currency_Z = parser.getText();
						} else if (text == 'amount') {
							amount = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Amount consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Properties {
		public String resourceId {get;set;} 
		public String name {get;set;} 
		public String balanceType {get;set;} 
		public Amount amount {get;set;} 
		public String transactionDate {get;set;} 

		public Properties(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'resourceId') {
							resourceId = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'balanceType') {
							balanceType = parser.getText();
						} else if (text == 'amount') {
							amount = new Amount(parser);
						} else if (text == 'transactionDate') {
							transactionDate = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Properties consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class TransactionDetails {
		public Properties properties {get;set;} 

		public TransactionDetails(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'properties') {
							properties = new Properties(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'TransactionDetails consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static JSON2Apex parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new JSON2Apex(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	






    private static List<AccountTransactionList> arrayOfAccountTransactionList(System.JSONParser p) {
        List<AccountTransactionList> res = new List<AccountTransactionList>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new AccountTransactionList(p));
        }
        return res;
    }


}
