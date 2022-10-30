import { DataSource } from "typeorm";
import { entities } from "../models";
import { Everything1666979834389 } from "./migrations/1666979834389-Everything";

export default new DataSource({
  type: "postgres",
  host: process.env.DB_HOST || "localhost",
  port: process.env.DB_PORT ? +process.env.DB_PORT : 5445,
  username: process.env.DB_USERNAME || "user",
  password: process.env.DB_PASSWORD || "password",
  database: process.env.DB_NAME || process.env.DB_DATABASE || "olympic_games",
  migrations: [Everything1666979834389],
  entities: entities,
});
