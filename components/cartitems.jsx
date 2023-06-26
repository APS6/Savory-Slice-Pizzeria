"use client";
import { useStateContext } from "@/context/stateContext";
import Image from "next/image";
import { urlForImage } from "@/sanity/lib/image";
import { useEffect, useState } from "react";

const CartItems = () => {
  const { cartItems, setCartItems } = useStateContext();
  const [expanded, setexpanded] = useState(false);

  const quantityhandler = (el, op) => {
    const newCartItems = [...cartItems];

    let index = cartItems.findIndex((item) => item._id === el._id);
    let quantity = newCartItems[index].quantity;

    if (op === "+") {
      newCartItems[index].quantity += 1;
    } else if (op === "-" && quantity !== 1) {
      newCartItems[index].quantity -= 1;
    } else if (op === "-" && quantity === 1) {
      newCartItems.splice(index, 1);
    }

    setCartItems(newCartItems);
  };

  const expand = () => {
    setexpanded(!expanded);
  };

  if (cartItems.length === 0) {
    return <span>Your cart is empty</span>;
  }
  return (
    <div className="">
      <div className={` overflow-scroll ${!expanded ? "max-h-[380px]" : ""}`}>
        {cartItems.map((pizza) => (
          <div
            key={pizza._id + pizza.size + pizza.cheese}
            className="mb-8 bg-[#ffddb3] flex items-center p-2 gap-2"
          >
            <Image
              src={urlForImage(pizza.image)}
              alt={pizza.slug.current}
              className=" w-1/2 h-full md:h-auto max-h-[145px]"
            />
            <div className="w-1/2">
              <h3 className="text-xl pb-4">{pizza.name}</h3>
              <div className="pb-4">
                <p>
                  {pizza.size} -
                  {pizza.size === "Regular" ? (
                    <span> 7 </span>
                  ) : pizza.size === "Medium" ? (
                    <span> 10 </span>
                  ) : pizza.size === "Large" ? (
                    <span> 12 </span>
                  ) : (
                    ""
                  )}
                  inches
                </p>
                <p>{pizza.cheese && "Extra Cheese"}</p>
              </div>
              <div className="flex justify-between w-full">
                <div className="bg-[white] flex p-1 rounded gap-4 text-lg">
                  <span
                    className="cursor-pointer select-none"
                    onClick={() => quantityhandler(pizza, "-")}
                  >
                    -
                  </span>
                  <span>{pizza.quantity}</span>
                  <span
                    className="cursor-pointer select-none"
                    onClick={() => quantityhandler(pizza, "+")}
                  >
                    +
                  </span>
                </div>{" "}
                <span className="text-lg">${pizza.tprice}</span>
              </div>
            </div>
          </div>
        ))}
      </div>
      {cartItems.length > 2 && (
        <div
          onClick={() => expand()}
          className="bg-[white] grid place-items-center py-4 md:hidden cursor-pointer"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
            style={{ width: "2rem", height: "2rem" }}
          >
            <path d="M6 9l6 6 6-6" />
          </svg>
        </div>
      )}
    </div>
  );
};

export default CartItems;
