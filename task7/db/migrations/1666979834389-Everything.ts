import {
  MigrationInterface,
  QueryRunner,
  Table,
  TableColumn,
  TableForeignKey,
} from "typeorm";

export class Everything1666979834389 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropSchema("olympic", true);
    await queryRunner.createSchema("olympic");

    // Country
    await queryRunner.createTable(
      new Table({
        schema: "olympic",
        name: "countries",
        columns: [
          new TableColumn({
            name: "name",
            type: "char(40)",
            isNullable: false,
          }),
          new TableColumn({
            name: "country_id",
            type: "char(3)",
            isPrimary: true,
            isNullable: false,
          }),
          new TableColumn({
            name: "area_sqkm",
            type: "integer",
            isNullable: false,
          }),
          new TableColumn({
            name: "population",
            type: "integer",
            isNullable: false,
          }),
        ],
      })
    );

    // Olympic
    await queryRunner.createTable(
      new Table({
        schema: "olympic",
        name: "olympics",
        columns: [
          new TableColumn({
            name: "olympic_id",
            type: "char(7)",
            isPrimary: true,
            isNullable: false,
          }),
          new TableColumn({
            name: "country_id",
            type: "char(3)",
            isNullable: false,
          }),
          new TableColumn({
            name: "city",
            type: "char(50)",
            isNullable: false,
          }),
          new TableColumn({
            name: "year",
            type: "integer",
            isNullable: false,
          }),
          new TableColumn({
            name: "start_date",
            type: "date",
            isNullable: false,
          }),
          new TableColumn({
            name: "end_date",
            type: "date",
            isNullable: false,
          }),
        ],
      })
    );

    await queryRunner.createForeignKey(
      new Table({
        name: "olympics",
        schema: "olympic",
      }),
      new TableForeignKey({
        columnNames: ["country_id"],
        referencedSchema: "olympic",
        referencedTableName: "countries",
        referencedColumnNames: ["country_id"],
      })
    );

    // Player
    await queryRunner.createTable(
      new Table({
        schema: "olympic",
        name: "players",
        columns: [
          new TableColumn({
            name: "player_id",
            type: "char(10)",
            isPrimary: true,
            isNullable: false,
          }),
          new TableColumn({
            name: "name",
            type: "char(40)",
            isNullable: false,
          }),
          new TableColumn({
            name: "country_id",
            type: "char(3)",
            isNullable: false,
          }),
          new TableColumn({
            name: "birth_date",
            type: "date",
            isNullable: false,
          }),
        ],
      })
    );

    await queryRunner.createForeignKey(
      new Table({
        name: "players",
        schema: "olympic",
      }),
      new TableForeignKey({
        columnNames: ["country_id"],
        referencedSchema: "olympic",
        referencedTableName: "countries",
        referencedColumnNames: ["country_id"],
      })
    );

    // Event
    await queryRunner.createTable(
      new Table({
        schema: "olympic",
        name: "events",
        columns: [
          new TableColumn({
            name: "event_id",
            type: "char(7)",
            isPrimary: true,
            isNullable: false,
          }),
          new TableColumn({
            name: "name",
            type: "char(40)",
            isNullable: false,
          }),
          new TableColumn({
            name: "event_type",
            type: "char(20)",
            isNullable: false,
          }),
          new TableColumn({
            name: "olympic_id",
            type: "char(7)",
            isNullable: false,
          }),
          new TableColumn({
            name: "is_team_event",
            type: "boolean",
            isNullable: false,
          }),
          new TableColumn({
            name: "num_players_in_team",
            type: "integer",
            isNullable: true,
          }),
          new TableColumn({
            name: "result_noted_in",
            type: "char(100)",
            isNullable: true,
          }),
        ],
      })
    );

    await queryRunner.createForeignKey(
      new Table({
        name: "events",
        schema: "olympic",
      }),
      new TableForeignKey({
        columnNames: ["olympic_id"],
        referencedSchema: "olympic",
        referencedTableName: "olympics",
        referencedColumnNames: ["olympic_id"],
      })
    );

    // Result
    await queryRunner.createTable(
      new Table({
        schema: "olympic",
        name: "results",
        columns: [
          new TableColumn({
            name: "event_id",
            type: "char(7)",
            isNullable: false,
            isPrimary: true,
          }),
          new TableColumn({
            name: "player_id",
            type: "char(10)",
            isNullable: false,
            isPrimary: true,
          }),
          new TableColumn({
            name: "medal",
            type: "char(7)",
            isNullable: true,
          }),
          new TableColumn({
            name: "result",
            type: "float",
            isNullable: false,
          }),
        ],
      })
    );

    await queryRunner.createForeignKeys(
      new Table({
        name: "results",
        schema: "olympic",
      }),
      [
        new TableForeignKey({
          columnNames: ["event_id"],
          referencedSchema: "olympic",
          referencedTableName: "events",
          referencedColumnNames: ["event_id"],
        }),
        new TableForeignKey({
          columnNames: ["player_id"],
          referencedSchema: "olympic",
          referencedTableName: "players",
          referencedColumnNames: ["player_id"],
        }),
      ]
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropSchema("olympic", true, true);
  }
}
