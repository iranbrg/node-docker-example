/* eslint-disable import/first, import/newline-after-import */
import dotenv from "dotenv";
dotenv.config({ path: process.env.NODE_ENV === "test" ? ".env.test" : ".env" });

import express from "express";
import routes from "./routes";

class App {
    public express: express.Application;

    public constructor() {
        this.express = express();

        this.middlewares();
        this.routes();
    }

    private middlewares(): void {
        this.express.use(express.json());
    }

    private routes(): void {
        this.express.use(routes);
    }
}

export default new App().express;
