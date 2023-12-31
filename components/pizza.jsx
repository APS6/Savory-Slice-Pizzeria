"use client";

import React, { Suspense, useState } from "react";
import Image from "next/image";
import { urlForImage } from "../sanity/lib/image";
import { useStateContext } from "../context/stateContext";
import * as Dialog from "@radix-ui/react-dialog";

const Pizza = (props) => {
  const pizzas = props.pizzas;
  const catslug = props.catslug;
  const { addItems } = useStateContext();

  const [selected, setSelected] = useState(false);
  const [selPizza, setSelPizza] = useState([]);

  const selecthandler = (el) => {
    setSelected(true);
    el = { ...el, size: "Regular", cheese: false, tprice: el.price };
    setSelPizza(el);
  };

  const sizehandler = (e) => {
    let cost = 0;

    if (e === "Regular") {
      cost = 0;
    } else if (e === "Medium") {
      cost = 2;
    } else if (e === "Large") {
      cost = 4;
    }

    setSelPizza((prevsel) => ({
      ...prevsel,
      size: e,
      tprice: (parseFloat(prevsel.price) + cost).toFixed(2),
    }));
  };
  const cheeseHandler = () => {
    setSelPizza((prevsel) => ({ ...prevsel, cheese: !prevsel.cheese }));

    if (!selPizza?.cheese === true) {
      setSelPizza((prevsel) => ({
        ...prevsel,
        tprice: (parseFloat(prevsel.tprice) + 2).toFixed(2),
        price: (parseFloat(prevsel.tprice) + 2).toFixed(2),
      }));
    } else if (selPizza?.cheese === true) {
      setSelPizza((prevsel) => ({
        ...prevsel,
        tprice: (parseFloat(prevsel.tprice) - 2).toFixed(2),
        price: (parseFloat(prevsel.tprice) - 2).toFixed(2),
      }));
    }
  };

  return (
    <>
      {pizzas?.map((pizza) => {
        if (catslug == pizza.category) {
          return (
            <div
              key={pizza._id}
              className="bg-[#ffddb3] shadow max-w-[400px] flex flex-col items-center rounded p-2 justify-around gap-4"
            >
              {pizza.image ? (
                <Suspense fallback={<p>Loading Image...</p>}>
                  <Image
                    src={urlForImage(pizza.image)}
                    alt={pizza.slug.current}
                    className="w-full h-[50%] rounded"
                  />
                </Suspense>
              ) : (
                <div>Failed to load image</div>
              )}
              <p className="text-xl ">{pizza.name}</p>
              <p className="mx-[3px] text-center">{pizza.ingredients}</p>
              <div className="flex justify-between w-[80%]">
                <span className="text-xl">${pizza.price}</span>
                <div
                  className="cursor-pointer"
                  onClick={() => selecthandler(pizza)}
                >
                  <svg
                    width="44"
                    height="38"
                    viewBox="0 0 44 38"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <g clipPath="url(#clip0_17_48)">
                      <path
                        d="M6.39704 9.05294H33.5826C35.7918 9.05294 37.5826 10.8438 37.5826 13.0529V24.2784C37.5826 26.4876 35.7918 28.2784 33.5826 28.2784H13.6489C11.7537 28.2784 10.1186 26.9484 9.73272 25.0929L6.39704 9.05294ZM6.39704 9.05294L5.04754 5.63295C4.89683 5.251 4.52795 5 4.11734 5H0"
                        stroke="black"
                        strokeWidth="1.5"
                        strokeLinecap="round"
                      />
                      <path
                        d="M22.9115 14.9918L22.9115 22.8368"
                        stroke="black"
                        strokeWidth="1.5"
                        strokeLinecap="round"
                      />
                      <path
                        d="M27.4535 18.9144L18.3698 18.9144"
                        stroke="black"
                        strokeWidth="1.5"
                        strokeLinecap="round"
                      />
                      <path
                        d="M16.9532 33.8959H16.9712"
                        stroke="black"
                        strokeWidth="3"
                        strokeLinecap="round"
                      />
                      <path
                        d="M31.6199 33.8959H31.6378"
                        stroke="black"
                        strokeWidth="3"
                        strokeLinecap="round"
                      />
                    </g>
                    <defs>
                      <clipPath id="clip0_17_48">
                        <rect width="44" height="38" rx="5" fill="white" />
                      </clipPath>
                    </defs>
                  </svg>
                </div>
              </div>
            </div>
          );
        }
      })}

      <Dialog.Root open={selected} onOpenChange={setSelected}>
        <Dialog.Portal>
          <Dialog.Overlay className="fixed inset-0 bg-[#000000] opacity-50 z-[69]" />
          <Dialog.Content className="bg-[#fdd7a9] shadow rounded z-[70] py-4 px-[1.5rem] md:w-[80%] md:max-w-[740px] md:h-80 fixed top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 flex flex-col md:flex-row items-center justify-evenly">
            <Image
              src={urlForImage(selPizza?.image)}
              alt={selPizza?.slug?.current}
              className=" w-[90%] md:w-1/2 md:h-[80%] max-w-[370px] object-cover rounded"
            />
            <div className="flex flex-col gap-8 mt-2 md:mt-0">
              <div>
                <h4 className="text-xl">{selPizza?.name}</h4>
                <span className="text-sm">
                  {selPizza?.size === "Regular" ? (
                    <span>7</span>
                  ) : selPizza?.size === "Medium" ? (
                    <span>10</span>
                  ) : selPizza?.size === "Large" ? (
                    <span>12</span>
                  ) : (
                    ""
                  )}{" "}
                  inches
                </span>
              </div>
              <div className="flex gap-6">
                <div
                  onClick={() => sizehandler("Regular")}
                  className="flex gap-1 items-center cursor-pointer"
                >
                  <span>Regular</span>
                  <div className="bg-[#ff8d30] w-4 h-4 rounded-full grid place-items-center">
                    {selPizza?.size === "Regular" ? (
                      <svg
                        width="13"
                        height="10"
                        viewBox="0 0 13 10"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <line
                          x1="0.344754"
                          y1="4.63786"
                          x2="4.90771"
                          y2="8.98176"
                          stroke="white"
                        />
                        <line
                          x1="4.62893"
                          y1="8.55404"
                          x2="11.7536"
                          y2="0.664897"
                          stroke="white"
                        />
                      </svg>
                    ) : (
                      ""
                    )}
                  </div>
                </div>
                <div
                  onClick={() => sizehandler("Medium")}
                  className="flex gap-1 items-center cursor-pointer"
                >
                  <span>Medium</span>
                  <div className="bg-[#ff8d30] w-4 h-4 rounded-full grid place-items-center">
                    {selPizza?.size === "Medium" ? (
                      <svg
                        width="13"
                        height="10"
                        viewBox="0 0 13 10"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <line
                          x1="0.344754"
                          y1="4.63786"
                          x2="4.90771"
                          y2="8.98176"
                          stroke="white"
                        />
                        <line
                          x1="4.62893"
                          y1="8.55404"
                          x2="11.7536"
                          y2="0.664897"
                          stroke="white"
                        />
                      </svg>
                    ) : (
                      ""
                    )}
                  </div>
                </div>
                <div
                  onClick={() => sizehandler("Large")}
                  className="flex gap-1 items-center cursor-pointer"
                >
                  <span>Large</span>
                  <div className="bg-[#ff8d30] w-4 h-4 rounded-full grid place-items-center">
                    {selPizza?.size === "Large" ? (
                      <svg
                        width="13"
                        height="10"
                        viewBox="0 0 13 10"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <line
                          x1="0.344754"
                          y1="4.63786"
                          x2="4.90771"
                          y2="8.98176"
                          stroke="white"
                        />
                        <line
                          x1="4.62893"
                          y1="8.55404"
                          x2="11.7536"
                          y2="0.664897"
                          stroke="white"
                        />
                      </svg>
                    ) : (
                      ""
                    )}
                  </div>
                </div>
              </div>
              <div
                onClick={() => cheeseHandler()}
                className="flex gap-1 items-center cursor-pointer"
              >
                Extra Cheese
                <div className="bg-[#ff8d30] w-4 h-4 rounded-full grid place-items-center">
                  {selPizza?.cheese && (
                    <svg
                      width="13"
                      height="10"
                      viewBox="0 0 13 10"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <line
                        x1="0.344754"
                        y1="4.63786"
                        x2="4.90771"
                        y2="8.98176"
                        stroke="white"
                      />
                      <line
                        x1="4.62893"
                        y1="8.55404"
                        x2="11.7536"
                        y2="0.664897"
                        stroke="white"
                      />
                    </svg>
                  )}
                </div>
              </div>
              <div className="flex justify-between">
                <span className="text-2xl">${selPizza?.tprice}</span>
                <div
                  className="px-4 py-2 bg-[#ff8d30] rounded-md text-[white] cursor-pointer"
                  onClick={() => {
                    addItems(selPizza), setSelected(false);
                  }}
                >
                  Add to Cart
                </div>
              </div>
            </div>
            <Dialog.Close className="absolute top-2 right-2 p-1 text-[#000] hover:bg-[#99999978] rounded-full grid place-items-center cursor-pointer">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="1.5rem"
                height="1.5rem"
                viewBox="0 0 24 24"
                fill="currentColor"
              >
                <path
                  fill="currentColor"
                  d="m12 13.4l-4.9 4.9q-.275.275-.7.275t-.7-.275q-.275-.275-.275-.7t.275-.7l4.9-4.9l-4.9-4.9q-.275-.275-.275-.7t.275-.7q.275-.275.7-.275t.7.275l4.9 4.9l4.9-4.9q.275-.275.7-.275t.7.275q.275.275.275.7t-.275.7L13.4 12l4.9 4.9q.275.275.275.7t-.275.7q-.275.275-.7.275t-.7-.275L12 13.4Z"
                ></path>
              </svg>
            </Dialog.Close>
          </Dialog.Content>
        </Dialog.Portal>
      </Dialog.Root>
    </>
  );
};

export default Pizza;
