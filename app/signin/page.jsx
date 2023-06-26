"use client";

import { getAuth, GoogleAuthProvider, signInWithPopup } from "firebase/auth";
import { initFirebase } from "@/firebase/app";
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
      <button onClick={() => signInWithGoogle()}>Sign in with google</button>
    </div>
  );
};

export default Signup;
