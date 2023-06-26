import React from "react";
import { client } from "@/sanity/lib/client";
import Category from "@/components/category";
import Image from "next/image";


// Sanity API 
async function getData() {
  const query = '*[_type == "pizza"]';
  const data = await client.fetch(query);

  if (!data) {
    throw new Error("Failed to fetch data");
  }

  return data;
}
async function getCat() {
  const cquery = '*[_type == "category"]';
  const cdata = await client.fetch(cquery);

  if (!cdata) {
    throw new Error("Failed to fetch data");
  }

  return cdata;
}


// MetaData
export const metadata = {
  title: "Order Online | Savory Slice",
  description:
    "Order pizza online from the Savory Slice Restaurant in Epstein Island",
};


// The Page
export default async function Order() {
  const pizzas = await getData();
  const categories = await getCat();

  return (
    <div className="grid place-items-center">
      <section className="h-[55vh] mt-8 md:mt-0 md:h-screen md:max-h-[600px] flex items-center w-full relative justify-center md:justify-between">
    <div className="grid gap-6 md:pl-8 text-center">
    <h1 className="text-col2 text-7xl md:text-8xl font-ff1 leading-[1.2] over">Order. Eat. <br /> Enjoy. </h1>
    <p className="my-7 text-lg md:text-2xl">Pizza Delivered at Your Doorstep!</p>
    </div>
    <Image src="/box-pizza.png" height="492" width="441" alt="pizza" className=" hidden md:block w-[40%] pr-4"/>
      </section>
     <Category categories={categories} pizzas={pizzas}/>
    </div>
  );
}
