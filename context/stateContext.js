"use client";

import React, { createContext, useContext, useState, useEffect } from "react";
import { toast } from "react-hot-toast";
import { useAuthContext } from "./authContext";
import getDocument from "@/firebase/firestore/getData";

const Context = createContext();

export const StateContext = ({ children }) => {

  const { user } = useAuthContext();

  const [cartItems, setCartItems] = useState([]);
  const [totalPrice, setTotalPrice] = useState(0);
  const [finalPrice, setFinalPrice] = useState(0);
  const [info, setInfo] = useState({});
  const [tax, setTax] = useState(0);
  const [qty, setqty] = useState(0)

  const addItems = (item) => {
    const check = cartItems.find((pizza) => pizza._id === item._id && pizza.size === item.size && pizza.cheese === item.cheese);

    if (!check) {
      setCartItems((prevcartItems) => [...prevcartItems, {...item, quantity: 1}]);
    } else {
      const updatedItems = cartItems.map((cartItem) => {
        if (cartItem._id === item._id && cartItem.size === item.size && cartItem.cheese === item.cheese) {
          return { ...cartItem, quantity: cartItem.quantity + 1 };
        }
        return cartItem;
      });
      setCartItems(updatedItems);
    }
    toast.success(`added ${item.name} to the cart`);
  };

  const  priceHandler = () => {
    const total = cartItems.reduce((acc, item) => {
      return acc + parseFloat(item.tprice) * item.quantity;
    }, 0)

    const quant = cartItems.reduce((acc, item) => {
      return acc + item.quantity;
    }, 0)

    const taxcalc = ((1 / 10) * total).toFixed(2);
    const final = (parseFloat(total) + parseFloat(taxcalc) + 1).toFixed(2);
  
    setTotalPrice(total.toFixed(2));
    setTax(taxcalc);
    setFinalPrice(final);
    setqty(quant);
  }

  useEffect(() => {
    priceHandler();
  },[cartItems])

  const fetchData = async () => {
    try {
      const { result, error } = await getDocument('users', user.uid);

      if (error) {
        console.log('Error retrieving document:', error);
      } else {
        if (result.exists()) {
          setInfo(result.data());
        } else {
          console.log('Document does not exist');
        }
      }
    } catch (e) {
      console.log('Error:', e);
    }
  };

  return (
    <Context.Provider
      value={{
        cartItems,
        setCartItems,
        addItems,
        totalPrice,
        tax,
        finalPrice,
        qty,
        info,
        fetchData,
      }}
    >
      {children}
    </Context.Provider>
  );
};

export const useStateContext = () => useContext(Context);
