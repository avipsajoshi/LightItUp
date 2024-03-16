//first request to server to create order
function paymentStart() {
  console.log("paymentStarted");
  let amount = document.getElementById("amount_field");
  console.log(amount.value);
  if (amount == "" || amount == null) {
    alert("amount is not present");
    return
  }
  //request server for order creation
  $.ajax(
    {
      url = '/creatOrder',
      data:JSON.stringify({amount:amount, info:'order_request'}),
      contentType:'application/json',
      type:'POST',
      dataType:'json',
      success:function(response){
        //will invoke when success
      },
      error:function(error){
        //invoked when error
      }
    }
          
  )
}