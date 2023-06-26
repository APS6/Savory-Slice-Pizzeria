import React from "react";
import { useStateContext } from "@/context/stateContext";
import Link from "next/link";
import { useAuthContext } from "@/context/authContext";

const Checkout = () => {
  const { finalPrice, qty, cartItems } = useStateContext();
  const {user} = useAuthContext();

  if (cartItems.length === 0) {
    return "";
  }

  return (
    <div className="md:hidden grid justify-items-center gap-4">
      <h3 className="text-2xl">Cart total ({qty} items) - ${finalPrice}</h3>
      <Link href={user ? '/Delivery' : '/signin'}><div className="px-8 py-2 text-lg bg-[#ff8d30] rounded-md text-[white]">Checkout</div></Link>
    </div>
  );
};

export default Checkout;
