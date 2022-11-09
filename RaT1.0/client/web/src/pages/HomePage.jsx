import React from "react";

const HomePage = () => {
    return(
        <div>
            <p>Home Page</p>
            <a href="/offers">
            <button>
                Offers
            </button>
            </a> 
            <a href="/requests">
            <button>
                Requests
            </button>
            </a> 
        </div>        
    )
}
export default HomePage;