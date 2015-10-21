# card_tokeniser
For bank transactions - stab with pheonix

# Idea
when there is a transaction happening at a POS, you will be contacted at /api/tokenise. You will revert with a string token after analysing the security risk involved. This is transfered to the merchant and now the merchant will make a call with this token and you authorise the payment.

# Pages
## Admin
  * Ability to add a merchant and enable API access (API Secret and API Key) for merchant.
  * Monitor API usage per merchant
  * TODO - Finish admin requirements
# API
## tokenise
URL: /api/tokenise
Verb:  GET
Input: card_no, valid_from, valid_thru, amount, currency
Output: 
  Success: {token: <token, string >, expires_at: <timestamp>}, 200
  Failure: {message: <reason, string>}, 406/409/417

## de-tokenise
URL: /api/tokenise
Verb:  GET
Input: token, amount, currency
Output: 
  Success: {transaction_id: <transaction_id, string >, amount, currency}, 200
  Failure: {message: <reason, string>}, 401/403/405/406/409


