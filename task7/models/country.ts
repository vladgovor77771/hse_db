import { Entity, Column, BaseEntity, OneToMany, JoinColumn } from "typeorm";
import Olympic from "./olympic";
import Player from "./player";

@Entity({ name: "countries", schema: "olympic" })
export default class Country extends BaseEntity {
  @Column({ name: "country_id", nullable: false, primary: true, length: 3 })
  countryId!: string;

  @Column({ nullable: false, length: 40 })
  name!: string;

  @Column({ name: "area_sqkm", nullable: false })
  areaSqkm!: number;

  @Column({ nullable: false })
  population!: number;

  constructor(countryId: string, name: string, areaSqkm: number, population: number) {
    super();
    this.countryId = countryId;
    this.name = name;
    this.areaSqkm = areaSqkm;
    this.population = population;
  }

  @OneToMany(type => Olympic, olympic => olympic.country)
  @JoinColumn({ name: "country_id" })
  olympics!: Olympic[];

  @OneToMany(type => Player, player => player.country)
  @JoinColumn({ name: "country_id" })
  players!: Player[];
}
