// Based on : https://blog.logrocket.com/complete-guide-authentication-with-react-router-v6/#using-nested-routes-and-outlet

import {createContext, useContext} from "react";
import {useLocalStorage} from "./useLocalStorage";

const AuthContext = createContext();

export const AuthProvider = ({children}) => {
  const [authData, setAuthData] = useLocalStorage("authdata", null);

  // call this function when you want to authenticate the user
  const login = async (authData) => {
    if (authData !== null && authData !== undefined) {
      setAuthData(authData);
      window.location.reload();
    }
  };

  // call this function to sign out logged in user
  const logout = () => {
    setAuthData(null);
    window.location.reload();
  };

  const value = {authData, logout, login};
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = () => {
  return useContext(AuthContext);
};
