import dataSource from "./db/ormconfig";
import {
  randomCountries,
  randomEvents,
  randomOlympics,
  randomPlayers,
  randomResults,
} from "./helpers";

async function main() {
  await dataSource.initialize();

  const res = await dataSource.transaction(async manager => {
    const countries = await manager.save(randomCountries(40));
    console.error("created countries");
    const olympics = await manager.save(randomOlympics(300, countries));
    console.error("created olympics");
    const players = await manager.save(randomPlayers(4000, countries));
    console.error("created players");
    const events = await manager.save(randomEvents(3000, olympics));
    console.error("created events");
    const results = await manager.save(randomResults(15000, events, players));
    console.error("created results");
    return {
      countries,
      olympics,
      players,
      events,
      results,
    };
  });

  console.error("done");
}

main();
