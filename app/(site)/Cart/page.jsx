"use client";

import CartItems from "../../../components/cartitems";
import Bill from "../../../components/bill";
import Checkout from "../../../components/mobilecheckout";

const Cart = () => {
  return (
    <div className="pt-28 pb-20 md:px-8 flex items-center">
      <section className="h-[80%] w-full flex flex-col gap-10">
    <Checkout />
        <h1 className="text-4xl md:text-5xl text-col2 justify-self-start flex ">
          Cart Items
        </h1>
        <div className="flex flex-col gap-8 md:flex-row justify-between w-full md:w-[95%]">
          <CartItems />
          <Bill />
        </div>
      </section>
    </div>
  );
};

export default Cart;
