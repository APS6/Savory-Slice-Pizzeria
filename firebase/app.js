// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
const firebaseConfig = {
  apiKey: "AIzaSyC821e4QKKUZqmFH9D0CQpV499avN0HBhw",
  authDomain: "savor-slice.firebaseapp.com",
  projectId: "savor-slice",
  storageBucket: "savor-slice.appspot.com",
  messagingSenderId: "681018589570",
  appId: "1:681018589570:web:ec84681718fac55d5c4f9b",
  measurementId: "G-ZNBWZ41VQF"
};


// Initialize Firebase
export const app = initializeApp(firebaseConfig);

export const initFirebase = () => {
    return app
}
