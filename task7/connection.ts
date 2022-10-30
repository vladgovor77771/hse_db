import { Connection, createConnection } from "typeorm";

interface DBSecrets {
  host: string;
  port: number;
  username: string;
  password: string;
  database: string;
}

function parseEnv(): DBSecrets {
  const host = process.env["DB_HOST"] || "localhost";
  const port = process.env["DB_PORT"] || "5444";
  const username = process.env["DB_USERNAME"] || "popov_stepan206";
  const password = process.env["DB_PASSWORD"] || "popov_stepan206";
  const database = process.env["DB_DATABASE"] || "popov_stepan206";

  if (!host || !port || !username || !password || !database) {
    throw new Error("Must specify db secrets in env!");
  }
  return {
    host,
    port: +port,
    username,
    password,
    database,
  };
}

export default async function getConnection(entities: any[]): Promise<Connection> {
  const secrets = parseEnv();
  return createConnection({
    type: "postgres",
    synchronize: false,
    ...secrets,
    entities,
    logging: true,
  });
}
