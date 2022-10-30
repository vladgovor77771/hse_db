import dataSource from "./db/ormconfig";
import { task1, task2, task3, task4, task5 } from "./queries";

async function main() {
  await dataSource.initialize();
  await task1(dataSource.manager);
  await task2(dataSource.manager);
  await task3(dataSource.manager);
  await task4(dataSource.manager);
  await task5(dataSource.manager);
}

main();
