"use client";

import React, { useState } from "react";
import { useStateContext } from "@/context/stateContext";
import { useAuthContext } from "@/context/authContext";
import Link from "next/link";

const Bill = () => {
  const {user} = useAuthContext();
  const { totalPrice, tax, finalPrice, cartItems } = useStateContext();

  if (cartItems.length === 0) {
    return '';
  }

  return (
    <div className="grid justify-items-center gap-8">
    <div className="bg-[#ffddb3] py-4 px-8">
      <h3 className="text-xl pb-6">Total Cost</h3>
      <div className="text-lg">
        <div className="grid grid-cols-2 gap-x-10 gap-y-2 pb-3 border-b-{black} border-b-2">
          <span>Cost</span>
          <span>${totalPrice}</span>
          <span>Delivery</span>
          <span>1$</span>
          <span>Tax <span className="text-sm">(10%)</span></span>
          <span>${tax}</span>
          <span></span>
        </div>
        <div className="pt-3 grid grid-cols-2 gap-x-10">
          <span>Total</span>
          <span>${finalPrice}</span>
        </div>
      </div>
    </div>
    <Link href={user ? '/Delivery' : '/signin'}>
    <div className="btn text-2xl">
      <span>Confirm Order</span>
    </div>
    </Link>
    </div>
  );
};

export default Bill;
