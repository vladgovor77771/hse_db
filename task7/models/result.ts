import { Entity, Column, BaseEntity, JoinColumn, ManyToOne } from "typeorm";
import Player from "./player";
import Event from "./event";

@Entity({ name: "results", schema: "olympic" })
export default class Result extends BaseEntity {
  @Column({ name: "event_id", primary: true })
  eventId!: string;

  @Column({ name: "player_id", primary: true })
  playerId!: string;

  @ManyToOne(type => Event, event => event.results)
  @JoinColumn({ name: "event_id" })
  event!: Event;

  @ManyToOne(type => Player, player => player.results)
  @JoinColumn({ name: "player_id" })
  player!: Player;

  @Column({ nullable: true, length: 7 })
  medal?: string;

  @Column({ nullable: false, type: "float" })
  result!: number;

  constructor(event: Event, player: Player, medal: string | undefined, result: number) {
    super();
    this.event = event;
    this.player = player;
    // this.eventId = event.eventId;
    // this.playerId = player.playerId;
    this.medal = medal;
    this.result = result;
  }
}
