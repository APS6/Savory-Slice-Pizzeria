import "./globals.css";
import Nav from "../../components/nav";
import Footer from "../../components/footer";
import { StateContext } from "../../context/stateContext";
import { AuthContextProvider } from "../../context/authContext";
import { Toaster } from "react-hot-toast";
import { Suspense } from "react";
import Loading from "./loading";


export const metadata = {
  title: "Savory Slice | Pizza Restaurant",
  description: "A Pizzaria in Epstein Island",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className="bg-colbg">
        <AuthContextProvider>
        <StateContext>
        <Toaster />
        <main className="w-full max-w-[1366px] m-auto px-5 relative">
        <Nav />
        <Suspense fallback={<Loading />}>
        {children}
        </Suspense>
        <Footer />
        </main>
        </StateContext>
        </AuthContextProvider>
      </body>
    </html>
  );
}
