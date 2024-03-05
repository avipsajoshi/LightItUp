//localStorage will store data in browser 

function add_to_cart(pid, pname, price) {
  let cart = localStorage.getItem("cart");
  if (cart === null) {
    //no cart
    let products = [];
    let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
    products.push(product);
    localStorage.setItem("cart", JSON.stringify(products));
    //converts the products array into string and save in cart local storage
  } else {
    //cart is already present
    
    let pcart = JSON.parse(cart);//converts the cart string to java object pcart
    //item is callback function
    let oldProduct = pcart.find((item) => item.productId === pid);
    if (oldProduct) {
      //increase cart's quantity
      oldProduct.productQuantity = oldProduct.productQuantity + 1;
      pcart.map((item) => {
        if (item.productId === oldProduct.productId) {
          item.productQuantity = oldProduct.productQuantity;
        }
      });
      localStorage.setItem("cart", JSON.stringify(pcart));



    } else {
      //add new product
      let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
      pcart.push(product);
      localStorage.setItem("cart", JSON.stringify(pcart));
    }


  }
}