import Image from "next/image";
import Link from "next/link";

export default async function Home() {
  return (
    <div>
      <section className=" pt-24 md:pt-16 md:h-screen md:max-h-[600px] grid items-center">
        <div className="flex flex-col md:flex-row justify-between items-center gap-16 md:gap-0">
          <div className="md:pl-24 pt-8 relative text-center md:text-left overflow-hidden">
            <h1 className="text-col2 text-7xl md:text-8xl font-ff1 leading-[1.2] lines relative inline">
              Savory
              <br />
              Slice
            </h1>
            <p className="my-7 md:w-[70%] text-lg md:text-2xl">
              Delicious Pizza Crafted with Passion
            </p>
            <Link href="/Order">
              <button className="btn text-2xl">
                <span>Get a Slice!</span>
              </button>
            </Link>
            <svg
              width="183"
              height="140"
              viewBox="0 0 183 140"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
              className="absolute top-[-15%] -left-4 md:left-0 w-[50%]"
            >
              <path
                d="M48.2395 47.8822C48.9532 49.3237 49.6585 50.7668 50.3147 52.2267C50.6745 52.9973 51.0241 53.7746 51.4497 54.5236C53.7281 58.52 56.0701 62.4982 58.2218 66.5375C59.5314 69.029 60.8069 71.531 62.0491 74.0435L63.897 77.8162L65.6897 81.6043C66.0264 82.3782 66.2815 83.1715 66.4524 83.9765C66.5421 84.3038 66.5282 84.6426 66.4129 84.9652C66.2972 85.2874 66.0831 85.5842 65.7881 85.8309C64.9906 86.5278 63.7235 86.3996 62.9802 85.454C62.5168 84.8299 62.157 84.1638 61.9093 83.4714C61.3061 81.9025 60.6176 80.3594 59.8443 78.8421C59.0782 77.3228 58.231 75.8276 57.3024 74.3568C56.7907 73.5445 56.1942 72.7185 55.927 71.8614C55.0695 69.1242 53.466 66.5857 52.3248 63.9248C51.4753 61.9475 50.4289 60.0169 49.5008 58.0574L47.0112 52.8178C46.1687 51.0751 45.3818 49.3144 44.5455 47.5689C44.245 46.8818 44.0038 46.1804 43.8237 45.4689C43.6751 44.793 43.5756 44.1115 43.5258 43.4272C43.4801 42.8218 43.9786 42.7025 44.5513 43.2393C45.3704 44.011 46.1186 44.8252 46.7894 45.6764C47.0658 46.0258 47.3165 46.389 47.5474 46.76C47.7582 47.1377 47.9694 47.5166 48.1795 47.8932L48.2395 47.8822Z"
                fill="#DB3A34"
              />
              <path
                d="M106.26 43.234L105.977 45.194L105.632 47.1512C105.512 47.8436 105.391 48.5394 105.349 49.2363C105.289 50.1659 105.245 51.0961 105.205 52.0262L105.065 54.815L104.801 60.391L104.454 67.2557L104.156 74.1224C104.101 74.8174 103.98 75.5084 103.796 76.1902C103.735 76.4719 103.589 76.739 103.37 76.97C103.15 77.2013 102.863 77.3897 102.532 77.5208C101.626 77.8977 100.675 77.5054 100.447 76.5691C100.316 75.9584 100.288 75.3371 100.365 74.7208C100.639 71.9174 100.682 69.1034 100.493 66.2959C100.378 65.5197 100.38 64.736 100.498 63.9598C101.042 61.5695 100.937 59.1413 101.293 56.7423C101.559 54.9604 101.659 53.1614 101.914 51.3761C102.385 48.1942 102.897 45.0178 103.56 41.8564C103.795 40.6543 104.288 39.4901 105.02 38.411C105.335 37.9434 105.855 38.0195 105.989 38.6019C106.172 39.4372 106.284 40.2808 106.323 41.1272C106.339 41.8272 106.3 42.5272 106.207 43.2239L106.26 43.234Z"
                fill="#DB3A34"
              />
              <path
                d="M154.691 63.0137C153.74 63.8901 152.783 64.7637 151.821 65.6345C151.284 66.08 150.782 66.5493 150.318 67.0404C149.119 68.3679 147.959 69.7161 146.799 71.0637C145.637 72.41 144.465 73.7492 143.266 75.0731C141.794 76.706 140.3 78.3264 138.81 79.9492L134.307 84.7991C133.821 85.2816 133.26 85.717 132.636 86.0953C132.054 86.4758 131.224 86.4842 130.325 86.2885C129.015 86.0031 128.127 85.1309 128.459 84.3229C128.693 83.8124 129.061 83.3448 129.543 82.9494C131.637 81.1054 133.44 79.0793 134.915 76.9126C135.327 76.3129 135.699 75.656 136.349 75.2094C138.414 73.7786 139.757 71.9306 141.577 70.3621C142.924 69.1942 144.123 67.9325 145.44 66.745C146.614 65.6861 147.799 64.6344 148.994 63.59L152.665 60.5114C153.617 59.7041 154.807 59.0825 156.136 58.6984C156.267 58.6533 156.413 58.6393 156.555 58.6583C156.696 58.6771 156.827 58.7278 156.931 58.8039C157.035 58.8801 157.106 58.9784 157.137 59.0859C157.167 59.1934 157.155 59.3054 157.101 59.4073C156.783 60.1135 156.41 60.8045 155.985 61.4768C155.587 62.0018 155.138 62.5036 154.642 62.9779L154.691 63.0137Z"
                fill="#DB3A34"
              />
              <path
                d="M165.458 96.0904C165.096 96.22 164.74 96.36 164.367 96.4729L163.246 96.8094C162.847 96.9206 162.459 97.0572 162.089 97.218C161.122 97.6738 160.174 98.159 159.199 98.6009C158.229 99.0517 157.256 99.498 156.264 99.916C155.043 100.432 153.812 100.932 152.56 101.399L148.804 102.803C148.397 102.928 147.964 102.995 147.525 102.999C147.096 103.022 146.616 102.724 146.146 102.274C145.462 101.619 145.163 100.755 145.548 100.377C145.795 100.153 146.128 99.9947 146.5 99.9247C148.142 99.5501 149.671 98.9304 150.997 98.1011C151.37 97.8718 151.726 97.5825 152.204 97.5363C153.723 97.3773 154.906 96.6843 156.301 96.3281C157.34 96.0691 158.284 95.6522 159.311 95.3702C161.14 94.8612 162.947 94.3208 164.803 93.8566C165.567 93.6555 166.395 93.6412 167.17 93.8157C167.265 93.8384 167.352 93.8767 167.425 93.9277C167.498 93.9789 167.556 94.0416 167.594 94.1116C167.632 94.1816 167.65 94.2572 167.646 94.3331C167.642 94.4087 167.617 94.4829 167.571 94.5504C167.411 94.7237 167.242 94.8934 167.066 95.0572C166.897 95.2207 166.711 95.373 166.509 95.5122C166.174 95.7166 165.815 95.8972 165.437 96.0518L165.458 96.0904Z"
                fill="#DB3A34"
              />
              <path
                d="M19.7881 89.1957C20.6173 89.5605 21.4401 89.9315 22.2564 90.3084C22.6821 90.5162 23.1239 90.7041 23.5793 90.8712C24.8148 91.2753 26.0467 91.6905 27.2698 92.1242C28.4902 92.5619 29.6879 93.0348 30.8627 93.543C32.2989 94.1797 33.7113 94.8497 35.0845 95.5649C36.4579 96.2797 37.8052 97.0225 39.1261 97.7937C39.5207 98.0471 39.8567 98.3495 40.1198 98.6883C40.3965 99.0055 40.3032 99.4739 40.0111 99.986C39.5851 100.731 38.6829 101.262 38.016 101.117C37.605 101.013 37.2357 100.83 36.9448 100.584C35.5752 99.5185 33.9424 98.6717 32.1412 98.0933C31.6439 97.9281 31.089 97.8051 30.73 97.5002C29.5828 96.5191 27.9967 96.0473 26.6461 95.2983C26.1411 95.0219 25.617 94.7666 25.076 94.5336C24.5416 94.2917 23.9976 94.0624 23.4662 93.8154C21.5704 92.9365 19.6554 92.0663 17.6865 91.2635C16.8725 90.9057 16.23 90.3574 15.8539 89.6994C15.6416 89.3956 15.8349 89.0689 16.3565 88.9135L16.8883 88.8023C16.9698 88.7819 17.0557 88.7737 17.1413 88.7788L17.3818 88.7821C17.6991 88.7889 18.0156 88.8101 18.3296 88.8457C18.5813 88.8765 18.8282 88.9275 19.0659 88.998C19.2979 89.0761 19.5261 89.1621 19.7592 89.2371L19.7881 89.1957Z"
                fill="#DB3A34"
              />
            </svg>
          </div>
          <Image
            src="/Pizza.png"
            alt="pizza"
            width="577"
            height="338"
            className=" w-[90%] md:w-[50%] xl:w-auto"
          />
        </div>
      </section>
      <section className="flex flex-col md:flex-row md:justify-around md:max-w-[1200px] items-center my-20 py-10 mx-auto text-center md:text-left">
        <h2 className="text-col2 font-ff1 text-5xl leading-[1.1] w-[13ch] max-w-[100%] md:w-1/2 lg:w-[40%] pb-6 md:pb-0">
          Savor Our Delectable Pizza
        </h2>
        <p className="text-lg md:w-[50%]">
          Experience the irresistible allure of our artisanal pizzas. Each bite
          delivers a symphony of flavors that will leave you craving more.
          Discover pizza perfection at Savory Slices.
        </p>
      </section>
      <section className="w-full border-y-[#8B4F4F] border-y-2 py-10 flex flex-col items-center gap-8">
        <h2 className="text-center font-ff1 text-5xl text-col2 w-[12ch] max-w-[100%] md:w-auto">
          Order Online with Ease
        </h2>
        <p className="text-lg text-center md:w-[50%]">
          Order your favorite pizzas online with just a few clicks and have them
          delivered straight to your doorstep.
        </p>
        <Link href="/Order">
          <button className="btn text-2xl">Order Now</button>
        </Link>
      </section>
      <section className="w-full py-14 flex lg:px-12 items-center">
        <div className="flex flex-col gap-8">
          <h2 className="text-5xl font-ff1 text-col2">Testimonials</h2>
          <div className=" lg:w-[60%] pb-6">
            <p className="text-lg">
              "The pizzas at Savory Slice are simply outstanding! The flavors
              are perfectly balanced, the crust is crispy, and the toppings are
              always fresh. It's our go-to place for a delicious pizza night
              with friends and family."
            </p>
            <span className="mt-2 ml-4 text-xl font-bold inline-block">
              - Sarah D, Epstein Island
            </span>
          </div>
          <div className=" lg:w-[50%]">
            <p className="text-lg">
              "I can't resist the mouthwatering pizzas from this place. Every
              slice is a slice of heaven! The quality of ingredients shines
              through, and the service is exceptional. It's no wonder they're
              the best in town."
            </p>
            <span className="mt-2 ml-4 text-xl font-bold inline-block">
              - Michael Dick, Sicilly
            </span>
          </div>
        </div>
        <Image
          src="/slice.png"
          alt="pizza"
          width="441"
          height="522"
          className="hidden lg:block w-[50%] h-[80%]"
        />
      </section>
      <section className="flex py-10 justify-center md:justify-around items-center">
        <div>
          <h2 className="text-col2 text-6xl font-ff1 pb-16">Try it yourself</h2>
          <div className="flex flex-col gap-8 items-center">
            <p className="text-xl w-[26ch]">
              <span className="inline-block">Visit us at Block 69 Epstein Island</span>{" "}
              <span className="inline-block"> Timing : 5am to 7pm</span>
            </p>
            <span className="inline-block text-4xl font-bold">Or</span>
            <Link href="/Order">
              <button className="btn text-3xl">Order Online</button>
            </Link>
          </div>
        </div>
        <Image
          src="/slice2.png"
          alt="pizza"
          width="455"
          height="423"
          className="hidden md:block w-[20%]"
        />
      </section>
    </div>
  );
}
