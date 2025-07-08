// app/javascript/item_price.js

const price = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value);
    const taxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    if (price >= 300 && price <= 9999999) {
      const tax = Math.floor(price * 0.1);
      const profit = price - tax;
      taxDom.textContent = tax;
      profitDom.textContent = profit;
    } else {
      taxDom.textContent = "-";
      profitDom.textContent = "-";
    }
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
