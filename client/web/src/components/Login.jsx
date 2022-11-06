import { useState } from "react";
import { useNavigate } from "react-router-dom";
import ProtectedRouts from "./ProtectedRoutes";


const Login = () => {
  
  const navigate = useNavigate();

  // const [isLogged, setIsLogged] = useState(false);

  const [login, setLogin] = useState("");
  const [password, setPassword] = useState("");
  const [message, setMessage] = useState("");

  let handleSubmit = async (e) => {
    e.preventDefault();
    try {
    const body = JSON.stringify({
      username: login,
      password: password})

    const headers = new Headers({
        "Content-Type": "application/json",
        "Content-Length": JSON.stringify(body).length
    })
      console.log(JSON.stringify({
        name: login,
        password: password}))
        let res = await fetch("http://localhost:8080/api/auth/login", {
        method: "POST",
        mode: "cors",
        // headers: headers,
        body: body
      })
      .then((response) => response.json()
      )
      .then(data => {
      console.log(data["access_token"]);
      console.log(data)
    })
      // let resJson = await res.json();
      if (res.status === 200) {
        setLogin("");
        setPassword("");
        setMessage("User login successfully");
        // var isAuth = true;
        // ProtectedRouts({isAuth})
        navigate("/home");
        var data = res.json()
        console.log(data["access_token"]);
      } 
      else {
        setMessage("Wrong login or password");
      }
    }
    catch (err) {
      console.log(err);
    }
  };

  return (
    <div className="Login">
      <form className="form" onSubmit={handleSubmit}>
        <input
          type="text"
          value={login}
          placeholder="login"
          onChange={(e) => setLogin(e.target.value)}
        />
        <input
          type="text"
          value={password}
          placeholder="password"
          onChange={(e) => setPassword(e.target.value)}
        />

        <button className="login" type="submit">Login</button>

        <div className="message">{message ? <p>{message}</p> : null}</div>
      </form>
    </div>
  );
}

export default Login