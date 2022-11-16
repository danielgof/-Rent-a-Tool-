import React from "react";

const HomePage = () => {
    return(
        <div className="container">
            <p>Home Page</p>
            <div className="btn">
                <a href="/offers">
                    Offers
                </a>
            </div>
            <div className="btn">
                <a href="/requests">
                    Requests
                </a> 
            </div> 
        </div>        
    )
}
export default HomePage;