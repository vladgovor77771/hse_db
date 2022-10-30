import { faker } from "@faker-js/faker";
import { Country, Event, Olympic, Player, Result } from "./models";
import lodash, { result } from "lodash";

export function pickRandomElement<T>(array: T[], throwIfEmpty: boolean = true): T {
  if (throwIfEmpty && array.length == 0) {
    throw new Error("Array is empty");
  }
  return array[randomBetween(array.length)];
}

export function randomBetween(from: number, to?: number): number {
  if (!to) {
    to = from;
    from = 0;
  }
  return from + Math.floor(Math.random() * (to - from));
}

export function generateManyRandomUniqueElements<T, Key>(
  generator: () => T,
  keyGetter: (t: T) => Key,
  count: number
): T[] {
  let res: T[] = [];
  let usedKeys: Set<Key> = new Set();
  while (res.length < count) {
    const value = generator();
    const key = keyGetter(value);
    if (usedKeys.has(key)) {
      continue;
    }
    usedKeys.add(key);
    res.push(value);
  }
  return res;
}

export function randomCountry(): Country {
  const code = faker.address.countryCode("alpha-3");
  const name = faker.address.country().slice(0, 40);
  const areaSqkm = randomBetween(5000, 17000000);
  const population = randomBetween(100000, 1000000000);
  return new Country(code, name, areaSqkm, population);
}

export function randomPlayer(countries: Country[]): () => Player {
  return function () {
    const id = faker.random.alphaNumeric(10);
    const country = faker.helpers.arrayElement(countries);
    const name = faker.name.fullName().slice(0, 40);
    const birthDate = faker.date.birthdate({ min: 18, max: 65, mode: "age" });
    return new Player(id, name, country, birthDate);
  };
}

export function randomOlympic(countries: Country[]): () => Olympic {
  return function () {
    const id = faker.random.alphaNumeric(7);
    const country = faker.helpers.arrayElement(countries);
    const city = faker.address.cityName().slice(0, 50);
    const year = randomBetween(1960, 2022);
    const startDate = faker.date.between(
      `${year}-01-01T00:00:00.000Z`,
      `${year}-06-01T00:00:00.000Z`
    );
    const endDate = faker.date.between(
      `${year}-06-01T00:00:00.000Z`,
      `${year}-12-31T00:00:00.000Z`
    );

    return new Olympic(id, country, city, year, startDate, endDate);
  };
}

export function randomEvent(olympics: Olympic[]): () => Event {
  return function () {
    const id = faker.random.alphaNumeric(7);
    const name = faker.random.words(3).slice(0, 40);
    const eventType = faker.random.word().slice(0, 20);
    const olympic = faker.helpers.arrayElement(olympics);
    const isTeamEvent = faker.helpers.arrayElement([true, false]);
    let numPlayersInTeam;
    if (isTeamEvent) {
      numPlayersInTeam = randomBetween(2, 20);
    }
    return new Event(id, name, eventType, olympic, isTeamEvent, numPlayersInTeam);
  };
}

export function randomResult(events: Event[], players: Player[]): () => Result {
  return function () {
    const event = faker.helpers.arrayElement(events);
    const player = faker.helpers.arrayElement(players);
    const medal = faker.helpers.arrayElement(["GOLD", "SILVER", "BRONZE", undefined]);
    const result = randomBetween(1, 100);
    return new Result(event, player, medal, result);
  };
}

export function randomCountries(count: number): Country[] {
  return generateManyRandomUniqueElements(
    randomCountry,
    country => country.countryId,
    count
  );
}

export function randomPlayers(count: number, countries: Country[]): Player[] {
  return generateManyRandomUniqueElements(
    randomPlayer(countries),
    player => player.playerId,
    count
  );
}

export function randomOlympics(count: number, countries: Country[]): Olympic[] {
  return generateManyRandomUniqueElements(
    randomOlympic(countries),
    olympic => olympic.olympicId,
    count
  );
}

export function randomEvents(count: number, olympics: Olympic[]): Event[] {
  return generateManyRandomUniqueElements(
    randomEvent(olympics),
    event => event.eventId,
    count
  );
}

export function randomResults(
  count: number,
  events: Event[],
  players: Player[]
): Result[] {
  let res = generateManyRandomUniqueElements(
    randomResult(events, players),
    result => `${result.event.eventId}_${result.player.playerId}`,
    count
  );

  const byEvent = lodash.groupBy(res, x => x.event.eventId);
  for (let [eventId, results] of Object.entries(byEvent)) {
    const event = results[0].event;
    if (!event.isTeamEvent) {
      const sorted = lodash.sortBy(results, x => x.result).reverse();
      sorted[0].medal = "GOLD";
      let cur = 0;
      const makeSameMedals = () => {
        while (cur < results.length - 1) {
          if (sorted[cur].result == sorted[cur + 1].result) {
            sorted[cur + 1].medal = sorted[cur].medal;
          } else {
            break;
          }
          ++cur;
        }
      };
      makeSameMedals();
      if (cur < results.length - 1) {
        sorted[++cur].medal = "SILVER";
        makeSameMedals();
      }
      if (cur < results.length - 1) {
        sorted[++cur].medal = "BRONZE";
        makeSameMedals();
      }

      ++cur;
      for (; cur < sorted.length; ++cur) {
        sorted[cur].medal = undefined;
      }
    } else {
      const byCountries = lodash.groupBy(results, x => x.player.country.countryId);
      const scoreByCountry: { [key: string]: number } = {};
      for (let countryId of Object.keys(byCountries)) {
        scoreByCountry[countryId] = lodash.sumBy(byCountries[countryId], x => x.result);
      }
      const sortedByScore = lodash
        .sortBy(Object.entries(scoreByCountry), x => x[1])
        .reverse()
        .map(x => ({ countryId: x[0], score: x[1] }));
      byCountries[sortedByScore[0].countryId][0].medal = "GOLD";
      let cur = 0;
      const makeSameMedals = () => {
        for (let i = 1; i < byCountries[sortedByScore[cur].countryId].length; ++i) {
          byCountries[sortedByScore[cur].countryId][i].medal =
            byCountries[sortedByScore[cur].countryId][0].medal;
        }
        while (cur < sortedByScore.length - 1) {
          if (sortedByScore[cur].score == sortedByScore[cur + 1].score) {
            for (
              let i = 0;
              i < byCountries[sortedByScore[cur + 1].countryId].length;
              ++i
            ) {
              byCountries[sortedByScore[cur + 1].countryId][i].medal =
                byCountries[sortedByScore[cur].countryId][0].medal;
            }
          } else {
            break;
          }
          ++cur;
        }
      };
      makeSameMedals();
      if (cur < sortedByScore.length - 1) {
        byCountries[sortedByScore[++cur].countryId][0].medal = "SILVER";
        makeSameMedals();
      }
      if (cur < sortedByScore.length - 1) {
        byCountries[sortedByScore[++cur].countryId][0].medal = "BRONZE";
        makeSameMedals();
      }

      ++cur;
      for (; cur < sortedByScore.length; ++cur) {
        for (let i = 0; i < byCountries[sortedByScore[cur].countryId].length; ++i) {
          byCountries[sortedByScore[cur].countryId][i].medal = undefined;
        }
      }
    }
  }

  return res;
}
