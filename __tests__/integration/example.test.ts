import request from "supertest";
import app from "../../src/app";

describe("Example", () => {
    test("Should return `Hello World", async () => {
        const response = await request(app).get("/v1");

        expect(response.status).toEqual(200);
        expect(response.body).toHaveProperty("message", "Hello World");
    })
})
