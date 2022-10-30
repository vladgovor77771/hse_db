import { Entity, Column, BaseEntity, OneToMany, JoinColumn, ManyToOne } from "typeorm";
import Country from "./country";
import Result from "./result";

@Entity({ name: "players", schema: "olympic" })
export default class Player extends BaseEntity {
  @Column({ name: "player_id", nullable: false, primary: true, length: 10 })
  playerId!: string;

  @Column({ nullable: false, length: 40 })
  name!: string;

  @ManyToOne(type => Country, country => country.players)
  @JoinColumn({ name: "country_id" })
  country!: Country;

  @Column({ name: "birth_date", type: "date" })
  birthDate!: Date;

  constructor(playerId: string, name: string, country: Country, birthDate: Date) {
    super();
    this.playerId = playerId;
    this.name = name;
    this.country = country;
    this.birthDate = birthDate;
  }

  @OneToMany(type => Result, result => result.player)
  @JoinColumn({ name: "player_id" })
  results!: Result[];
}
