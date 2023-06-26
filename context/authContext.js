'use client'

import React from 'react';
import {
    onAuthStateChanged,
    getAuth,
} from 'firebase/auth';
import { initFirebase } from '@/firebase/app';

const auth = getAuth(initFirebase());

export const AuthContext = React.createContext({});

export const useAuthContext = () => React.useContext(AuthContext);

export const AuthContextProvider = ({
    children,
}) => {
    const [user, setUser] = React.useState(null);
    const [loading, setLoading] = React.useState(true);

    React.useEffect(() => {
        const unsubscribe = onAuthStateChanged(auth, (user) => {
            if (user) {
                setUser(user);
            } else {
                setUser(null);
            }
            setLoading(false);
        });

        return () => unsubscribe();
    }, []);

    return (
        <AuthContext.Provider value={{ user }}>
            {loading ? <div className='h-screen grid place-items-center text-6xl'><span>Loading...</span> </div> : children}
        </AuthContext.Provider>
    );
};
