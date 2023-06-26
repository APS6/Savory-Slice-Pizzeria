import Image from "next/image";
import React from "react";

const Footer = () => {
  return (
    <footer className="flex flex-col md:flex-row py-8 w-full gap-8 md:gap-0 md:flex-wrap md:justify-around items-center">
      <Image src="/Logo.png" alt="Logo" width="307" height="132" className="" />
      <div className="flex gap-8 md:gap-16 flex-wrap">
        <div className="flex flex-col gap-4">
          <div>
            <h5 className="text-lg">Phone</h5>
            <span>+69 4242424242</span>
          </div>
          <div>
            <h5 className="text-lg">Mail</h5>
            <span>SavorySlice@coolmail.com</span>
          </div>
        </div>
        <div className="flex flex-col items-center justify-center text-lg">
          <div>
          <p>Visit us at Block 42 Epstein Island</p>
          <p>Timings : 5am to 8pm</p>
          </div>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
