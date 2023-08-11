"use client";

import { getAuth, GoogleAuthProvider, signInWithPopup } from "firebase/auth";
import { initFirebase } from "../../../firebase/app";
import { useAuthState } from "react-firebase-hooks/auth";
import { useRouter } from "next/navigation";
import React from "react";

const Signup = () => {
  initFirebase();
  const provider = new GoogleAuthProvider();
  provider.setCustomParameters({ prompt: "select_account" });
  const auth = getAuth();
  const [user, loading] = useAuthState(auth);
  const router = useRouter();
  if (loading) {
    <div>loading</div>;
  }
  if (user) {
    router.push("/Delivery");
  }

  const signInWithGoogle = async () => {
    try {
      const result = await signInWithPopup(auth, provider);
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <div className="h-screen grid place-items-center">
      <div className="h-44 w-72 bg-[#fdd6a5] shadow flex flex-col items-center p-6">
        <h2 className="text-2xl text-col2 font-ff1">Login to continue</h2>
        <div className="w-full bg-col2 mt-1 h-[2px]"></div>
        <div className="w-full grid place-items-center h-[90%]">
      <button onClick={() => signInWithGoogle()} className="p-4 text-lg"
      >Sign in with google</button>
      </div>
      </div>
    </div>
  );
};

export default Signup;
