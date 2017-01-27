# README

This project was built as one part coding challenge, one part learning React Native

## Problem

Create a bar code scanning application in react native. When
the app starts, it should start a camera. The user can then scan a upc
code of a product using the camera. If the upc code matches with one
of the upc codes we have in our database then the application shows a
pop up with success message. If the code does not match then the
application shows a failure message. Thats it.

For the database of upc codes, you should create a simple server
application end point that can return a list of upc codes in the
following json format. please create an endpoint on the internet so
that its accessible over the web. Also, the endpoint should have a
simple form in which we can add new upc codes. You can add the upc
codes for any products you have at home to test it out.

### Sample JSON

```JSON
"upc":[
{"product_name":"Lacroix Tangerine", "upc":"24463061163"},
{"product_name":"ABC Sparkling water", "upc":"52000328660"},
{"product_name":"Luke's cheddar chips","upc":"84114112729"}
]
```
**Constraints:**
  - UPC Codes are 12 Digits Long

## Implementation
