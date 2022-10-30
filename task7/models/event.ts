import { Entity, Column, BaseEntity, OneToMany, JoinColumn, ManyToOne } from "typeorm";
import Olympic from "./olympic";
import Result from "./result";

@Entity({ name: "events", schema: "olympic" })
export default class Event extends BaseEntity {
  @Column({ name: "event_id", nullable: false, primary: true, length: 7 })
  eventId!: string;

  @Column({ nullable: false, length: 40 })
  name!: string;

  @Column({ name: "event_type", nullable: false, length: 20 })
  eventType!: string;

  @ManyToOne(type => Olympic, olympic => olympic.events)
  @JoinColumn({ name: "olympic_id" })
  olympic!: Olympic;

  @Column({ name: "is_team_event", nullable: false })
  isTeamEvent!: boolean;

  @Column({ name: "num_players_in_team", nullable: true })
  numPlayersInTeam!: number;

  @Column({ name: "result_noted_in", nullable: true, length: 100 })
  resultNotedIn!: string;

  constructor(
    eventId: string,
    name: string,
    eventType: string,
    olympic: Olympic,
    isTeamEvent: boolean,
    numPlayersInTeam?: number,
    resultNotedIn?: string
  ) {
    super();
    this.eventId = eventId;
    this.name = name;
    this.eventType = eventType;
    this.olympic = olympic;
    this.isTeamEvent = isTeamEvent;
    if (numPlayersInTeam) {
      this.numPlayersInTeam = numPlayersInTeam;
    }
    if (resultNotedIn) {
      this.resultNotedIn = resultNotedIn;
    }
  }

  @OneToMany(type => Result, result => result.event)
  @JoinColumn({ name: "event_id" })
  results!: Result[];
}
