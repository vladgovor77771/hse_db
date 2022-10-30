import { Entity, Column, BaseEntity, OneToMany, JoinColumn, ManyToOne } from "typeorm";
import Country from "./country";
import Event from "./event";

@Entity({ name: "olympics", schema: "olympic" })
export default class Olympic extends BaseEntity {
  @Column({ name: "olympic_id", nullable: false, primary: true, length: 7 })
  olympicId!: string;

  @ManyToOne(type => Country, country => country.olympics)
  @JoinColumn({ name: "country_id" })
  country!: Country;

  @Column({ nullable: false, length: 50 })
  city!: string;

  @Column({ nullable: false })
  year!: number;

  @Column({ name: "start_date", nullable: false, type: "date" })
  startDate!: Date;

  @Column({ name: "end_date", nullable: false, type: "date" })
  endDate!: Date;

  constructor(
    olympicId: string,
    country: Country,
    city: string,
    year: number,
    startDate: Date,
    endDate: Date
  ) {
    super();
    this.olympicId = olympicId;
    this.country = country;
    this.city = city;
    this.year = year;
    this.startDate = startDate;
    this.endDate = endDate;
  }

  @OneToMany(type => Event, event => event.olympic)
  @JoinColumn({ name: "olympic_id" })
  events!: Event[];
}
