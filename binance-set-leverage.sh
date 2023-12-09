#!/bin/bash

# Your Binance API Key
API_KEY="your_api_key"

# Your Binance API Secret
API_SECRET="your_api_secret"

# The base URL for Binance API
BASE_URL="https://fapi.binance.com"

# The endpoint for getting exchange information
INFO_ENDPOINT="/fapi/v1/exchangeInfo"

# The endpoint for changing leverage
LEVERAGE_ENDPOINT="/fapi/v1/leverage"

# The endpoint for changing margin type
MARGIN_TYPE_ENDPOINT="/fapi/v1/marginType"

# The endpoint for getting account information
ACCOUNT_INFO_ENDPOINT="/fapi/v2/account"

# The new leverage
LEVERAGE=5

# Log file
LOG_FILE="binance_leverage.log"

# Get the exchange information
EXCHANGE_INFO=$(curl -H "X-MBX-APIKEY: $API_KEY" -X GET "$BASE_URL$INFO_ENDPOINT")

# Extract the symbols from the exchange information
SYMBOLS=$(echo $EXCHANGE_INFO | jq -r '.symbols[].symbol')

# Loop through all symbols and set the leverage and margin type
for SYMBOL in $SYMBOLS
do
  # Generate the query string for changing leverage
  QUERY_STRING="symbol=$SYMBOL&leverage=$LEVERAGE&timestamp=$(date +%s)000"

  # Generate the signature
  SIGNATURE=$(echo -n "$QUERY_STRING" | openssl dgst -sha256 -hmac "$API_SECRET" -binary | xxd -p)

  # Make the API request to change leverage
  URL="$BASE_URL$LEVERAGE_ENDPOINT?$QUERY_STRING&signature=$SIGNATURE"
  
  # Remove newline and carriage return characters
  URL=$(echo "$URL" | tr -d '\n' | tr -d '\r')

  # Make the API request and log the response
  RESPONSE=$(curl -H "X-MBX-APIKEY: $API_KEY" -X POST "$URL")
  echo "Changed leverage for $SYMBOL: $RESPONSE" >> $LOG_FILE

  # Generate the query string for changing margin type
  QUERY_STRING="symbol=$SYMBOL&marginType=ISOLATED&timestamp=$(date +%s)000"

  # Generate the signature
  SIGNATURE=$(echo -n "$QUERY_STRING" | openssl dgst -sha256 -hmac "$API_SECRET" -binary | xxd -p)

  # Make the API request to change margin type
  URL="$BASE_URL$MARGIN_TYPE_ENDPOINT?$QUERY_STRING&signature=$SIGNATURE"
  
  # Remove newline and carriage return characters
  URL=$(echo "$URL" | tr -d '\n' | tr -d '\r')

  # Make the API request and log the response
  RESPONSE=$(curl -H "X-MBX-APIKEY: $API_KEY" -X POST "$URL")
  echo "Changed margin type for $SYMBOL: $RESPONSE" >> $LOG_FILE
done

# Generate the query string for getting account information
QUERY_STRING="timestamp=$(date +%s)000"

# Generate the signature
SIGNATURE=$(echo -n "$QUERY_STRING" | openssl dgst -sha256 -hmac "$API_SECRET" -binary | xxd -p)

# Make the API request to get account information
URL="$BASE_URL$ACCOUNT_INFO_ENDPOINT?$QUERY_STRING&signature=$SIGNATURE"

# Remove newline and carriage return characters
URL=$(echo "$URL" | tr -d '\n' | tr -d '\r')

# Make the API request and log the response
RESPONSE=$(curl -H "X-MBX-APIKEY: $API_KEY" -X GET "$URL")
echo "Account information: $RESPONSE" >> $LOG_FILE
