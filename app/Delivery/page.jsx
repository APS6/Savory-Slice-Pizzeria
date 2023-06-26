"use client";
import React, { useEffect, useState,} from "react";
import addData from "@/firebase/firestore/addData";
import { useAuthContext } from "@/context/authContext";
import { useStateContext } from "@/context/stateContext";
import toast from 'react-hot-toast';
import getStripe from "@/lib/getStripe";


const Delivery = () => {
  const { user } = useAuthContext();
  const { info, fetchData, cartItems } = useStateContext();

  const handleCheckout = async () => {
    const stripe = await getStripe();

    const response = await fetch('/api/stripe', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(cartItems),
    });

    if(response.statusCode === 500) return;
    
    const data = await response.json();

    toast.loading('Redirecting...');

    stripe.redirectToCheckout({ sessionId: data.id });
  }


  const [name, setName] = useState("");
  const [mobile, setMobile] = useState("");
  const [address, setAddress] = useState("");
  const [email, setEmail] = useState("");

  useEffect(() => {
    fetchData();
  }, [user.uid]);

  const formHandler = async (e) => {
    e.preventDefault();
    const data = {
      name: name,
      phone: mobile,
      address: address,
      email: email,
    };
    const { result, error } = await addData("users", user.uid, data);

    if (error) {
      return console.log(error);
    } else {
      router.push("/pay");
    }
  };

  const nameHandler = (e) => {
    setName(e.target.value);
  };
  const mobileHandler = (e) => {
    setMobile(e.target.value);
  };
  const emailHandler = (e) => {
    setEmail(e.target.value);
  };
  const addressHandler = (e) => {
    setAddress(e.target.value);
  };

  return (
    <div className="md:flex py-24 justify-center">
      {info && (
        <div className="grid place-items-center md:w-[32%] md:border-r-2 border-r-col4 pb-16 md:pb-0">
          <div className="w-[70%] md:w-auto">
            <h2 className="text-3xl text-col2 pb-2 md:pb-6">Continue as -</h2>
            <div className="pb-6">
              <span className="inline-block text-xl">{info.name}</span>
              <br />
              <span className="inline-block">Phone: {info.phone}</span>
              <span className="inline-block">{info.address}</span>
              {info.email && <span>{info.email}</span>}
            </div>
            <button
              type="button"
              onClick={handleCheckout}
              className="px-8 py-2 text-lg bg-[#ff8d30] rounded-md text-[white] cursor-pointer"
            >
              Pay now
            </button>
          </div>
        </div>
      )}
      <div className="grid place-items-center md:ml-8">
        <h1 className="text-3xl text-col2 font-ff1 pb-8">
          Enter your delivery address
        </h1>
        <form onSubmit={formHandler} className="grid justify-items-center">
          <div className="grid gap-8 md:grid-cols-2 pb-4">
            <div>
              <label htmlFor="name" className="block text-sm pb-2">
                Name
              </label>
              <input
                onChange={(e) => nameHandler(e)}
                type="text"
                name="name"
                placeholder="Enter your Name"
                className="rounded p-2 border-2 border-[grey] focus:border-col3 focus:ring-0 w-80"
              />
            </div>
            <div>
              <label htmlFor="phone" className="block text-sm pb-2">
                Mobile
              </label>
              <input
                onChange={(e) => mobileHandler(e)}
                required
                type="text"
                name="phone"
                placeholder="Enter your Mobile no"
                className="rounded p-2 border-2 border-[grey] focus:border-col3 focus:ring-0 w-80"
              />
            </div>
            <div>
              <label htmlFor="address" className="block text-sm pb-2">
                Address
              </label>
              <input
                onChange={(e) => addressHandler(e)}
                required
                type="text"
                name="address"
                placeholder="Enter your Adress"
                className="rounded p-2 border-2 border-[grey] focus:border-col3 focus:ring-0 w-80"
              />
            </div>
            <div>
              <label htmlFor="email" className="block text-sm pb-2">
                Email (optional)
              </label>
              <input
                onChange={(e) => emailHandler(e)}
                type="email"
                name="email"
                placeholder="Enter yourEmail"
                className="rounded p-2 border-2 border-[grey] focus:border-col3 focus:ring-0 w-80"
              />
            </div>
            <div className="md:col-span-2">
              <label htmlFor="city" className="block text-sm pb-2">
                City
              </label>
              <input
                type="text"
                name="city"
                value="Epstein Island"
                readOnly
                className="cursor-default rounded p-2 border-2 border-[grey] focus:ring-0 w-full"
              />
            </div>
          </div>
          <button type="submit" className="btn text-xl px-8">
            Pay now
          </button>
        </form>
      </div>
    </div>
  );
};

export default Delivery;
