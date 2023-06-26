import React from "react";
import Link from "next/link";

const Nav = () => {
  return (
    <nav className="w-full flex items-center m-auto h-16 z-50 fixed bg-colbg md:bg-none top-0">
      <div className="w-[91%] md:w-[96%] flex justify-between items-center">
      <h2><Link href="/"  className="text-xl md:text-3xl font-ff1 flex gap-[.5ch]"><span>Savory</span><span className="hidden min-[380px]:block">Slice</span></Link></h2>
      <ul className="flex gap-4 md:gap-16 items-center md:text-lg font-ff2">
        <li>
          <Link href="/">Home</Link>
        </li>
        <li>
          <Link href="/Order">Order Online</Link>
        </li>
        <li>
          <Link href="/Cart">
            <svg
              width="40"
              height="36"
              viewBox="0 0 45 41"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M9.82887 8.21666H37.7232C39.9324 8.21666 41.7232 10.0075 41.7232 12.2167V24.96C41.7232 27.1691 39.9324 28.96 37.7232 28.96H17.2064C15.2955 28.96 13.6515 27.6084 13.2819 25.7336L9.82887 8.21666ZM9.82887 8.21666L8.43626 4.49342C8.29012 4.1027 7.91679 3.84375 7.49963 3.84375H3.28644"
                stroke="#333333"
                strokeWidth="1.5"
                strokeLinecap="round"
              />
              <path
                d="M20.625 35.0208H20.643"
                stroke="#333333"
                strokeWidth="3"
                strokeLinecap="round"
              />
              <path
                d="M35.625 35.0208H35.643"
                stroke="#333333"
                strokeWidth="3"
                strokeLinecap="round"
              />
            </svg>
          </Link>
        </li>
      </ul>
      </div>
    </nav>
  );
};

export default Nav;
