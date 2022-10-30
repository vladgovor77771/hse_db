import { EntityManager } from "typeorm";

// Для Олимпийских игр 2004 года сгенерируйте список
//   год рождения игроков
//   количество игроков, родившихся в каждый из годов, которые выиграли по крайней мере одну золотую медаль (я понял так, что рассматриваем результаты только за выбранные олимпиады)
//   количество золотых медалей, завоеванных игроками, родившимися в каждый из годов

export async function task1(manager: EntityManager) {
  // "с помощью ORM" xd
  const res = await manager.query(
    `
    WITH
    results_of_olympics_in_2004 AS (
      SELECT
        result.player_id,
        result.medal
      FROM olympic.results result
      LEFT JOIN olympic.events event ON result.event_id = event.event_id
      LEFT JOIN olympic.olympics olympic ON event.olympic_id = olympic.olympic_id
      WHERE olympic.year = 2004
    ),
    players_with_at_least_one_gold_medal AS (
      SELECT
        player.player_id AS player_id,
        date_part('year', player.birth_date) as birth_year,
        count(medal) as total_gold_medals
      FROM results_of_olympics_in_2004 result
      LEFT JOIN olympic.players player ON player.player_id = result.player_id
      WHERE medal = 'GOLD'
      GROUP BY player.player_id
      ORDER BY total_gold_medals DESC
    ),
    aggregated_by_birth_year AS (
      SELECT
        player.birth_year,
        count(player.total_gold_medals) as total_players_with_at_least_one_gold_medal,
        sum(player.total_gold_medals) as total_gold_medals
      FROM players_with_at_least_one_gold_medal player
      GROUP BY player.birth_year
      ORDER BY total_gold_medals
    )

    SELECT * FROM aggregated_by_birth_year;
    `
  );
  console.log(res);
}

// Перечислите все индивидуальные (не групповые) соревнования,
// в которых была ничья в счете, и два или более игрока выиграли
// золотую медаль.

export async function task2(manager: EntityManager) {
  const res = await manager.query(
    `
    WITH scope AS (
      SELECT event.event_id AS event_id, count(result.medal) AS gold_medal_count, count(DISTINCT result.result) AS uniq_results
      FROM olympic.results result
      LEFT JOIN olympic.events event ON result.event_id = event.event_id
      WHERE event.is_team_event = FALSE AND result.medal = 'GOLD'
      GROUP BY event.event_id
    )
    SELECT * FROM scope
    WHERE gold_medal_count > 1 AND uniq_results = 1
    `
  );

  console.log(res);
}

// Найдите всех игроков, которые выиграли хотя бы одну медаль (GOLD, SILVER и
// BRONZE) на одной Олимпиаде. (player-name, olympic-id).

export async function task3(manager: EntityManager) {
  const res = await manager.query(
    `
    WITH
    players_with_at_least_one_gold_medal AS (
      SELECT
        player.player_id AS player_id,
        player.name AS player_name,
        array_agg(olympic.olympic_id) as olympics_with_medals_won
      FROM olympic.results result
      LEFT JOIN olympic.players player ON player.player_id = result.player_id
      LEFT JOIN olympic.events event ON result.event_id = event.event_id
      LEFT JOIN olympic.olympics olympic ON event.olympic_id = olympic.olympic_id
      WHERE medal IN ('GOLD', 'SILVER', 'BRONZE')
      GROUP BY player.player_id
    )
    SELECT player_name, olympics_with_medals_won[1] AS olympic_id
    FROM players_with_at_least_one_gold_medal
    WHERE array_length(olympics_with_medals_won, 1) = 1
    `
  );

  console.log(res);
}

// В какой стране был наибольший процент игроков (из перечисленных
// в наборе данных), чьи имена начинались с гласной?

export async function task4(manager: EntityManager) {
  const res = await manager.query(
    `
    WITH aggregated AS (
      SELECT
        country.country_id,
        count(
          CASE
            WHEN SUBSTR(player.name,1,1) IN('A','E','I','O','U', 'Y', 'a', 'e', 'i', 'o', 'u', 'y') 
            THEN 1
            ELSE NULL 
          END
        ) AS names_starts_from_vowel,
        count(player.name) AS names_total
      FROM olympic.players player
      LEFT JOIN olympic.countries country ON player.country_id = country.country_id
      GROUP BY country.country_id
    )
    SELECT
      country_id,
      names_starts_from_vowel::float / names_total * 100 AS names_starts_from_vovel_pct
    FROM aggregated
    ORDER BY names_starts_from_vovel_pct DESC
    LIMIT 1
    `
  );

  console.log(res);
}

// Для Олимпийских игр 2000 года найдите 5 стран с минимальным
// соотношением количества групповых медалей к численности населения.

export async function task5(manager: EntityManager) {
  const res = await manager.query(
    `
    SELECT 
      country.country_id,
      COUNT(result.medal)::float / country.population AS group_medals_to_population_pct
    FROM olympic.results result
    LEFT JOIN olympic.players player ON result.player_id = player.player_id
    LEFT JOIN olympic.countries country ON player.country_id = country.country_id
    LEFT JOIN olympic.events event ON result.event_id = event.event_id
    LEFT JOIN olympic.olympics olympic ON event.olympic_id = olympic.olympic_id
    WHERE olympic.year = 2000 AND event.is_team_event AND result.medal IN ('GOLD', 'SILVER', 'BRONZE')
    GROUP BY country.country_id
    ORDER BY group_medals_to_population_pct
    LIMIT 5
    `
  );

  console.log(res);
}
