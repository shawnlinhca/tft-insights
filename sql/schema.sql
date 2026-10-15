CREATE TABLE IF NOT EXISTS patches (
  patch_id     serial PRIMARY KEY,
  label        text NOT NULL,
  set_number   int  NOT NULL,
  starts_at    timestamptz NOT NULL,
  ends_at      timestamptz
);

CREATE TABLE IF NOT EXISTS matches (
  match_id       text PRIMARY KEY,
  set_number     int  NOT NULL,
  set_core_name  text,
  queue_id       int  NOT NULL,
  game_type      text,
  game_datetime  timestamptz NOT NULL,
  game_length    real,
  region         text
);

CREATE TABLE IF NOT EXISTS participants (
  match_id                text NOT NULL REFERENCES matches ON DELETE CASCADE,
  puuid                   text NOT NULL,
  placement               smallint NOT NULL CHECK (placement BETWEEN 1 AND 8),
  level                   smallint,
  gold_left               smallint,
  last_round              smallint,
  players_eliminated      smallint,
  total_damage_to_players int,
  time_eliminated         real,
  win                     boolean,
  PRIMARY KEY (match_id, puuid)
);

CREATE TABLE IF NOT EXISTS participant_units (
  match_id     text NOT NULL,
  puuid        text NOT NULL,
  slot         smallint NOT NULL,
  unit_id      text NOT NULL,
  tier         smallint NOT NULL,
  rarity       smallint,
  PRIMARY KEY (match_id, puuid, slot),
  FOREIGN KEY (match_id, puuid) REFERENCES participants ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS participant_unit_items (
  match_id  text NOT NULL,
  puuid     text NOT NULL,
  slot      smallint NOT NULL,
  item_slot smallint NOT NULL,
  item_id   text NOT NULL,
  PRIMARY KEY (match_id, puuid, slot, item_slot),
  FOREIGN KEY (match_id, puuid, slot) REFERENCES participant_units ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS participant_traits (
  match_id     text NOT NULL,
  puuid        text NOT NULL,
  trait_id     text NOT NULL,
  num_units    smallint,
  style        smallint,
  tier_current smallint,
  tier_total   smallint,
  PRIMARY KEY (match_id, puuid, trait_id),
  FOREIGN KEY (match_id, puuid) REFERENCES participants ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS dim_units  (unit_id  text, set_number int, name text, cost smallint, PRIMARY KEY (unit_id, set_number));
CREATE TABLE IF NOT EXISTS dim_items  (item_id  text, set_number int, name text, PRIMARY KEY (item_id, set_number));
CREATE TABLE IF NOT EXISTS dim_traits (trait_id text, set_number int, name text, PRIMARY KEY (trait_id, set_number));

CREATE INDEX IF NOT EXISTS idx_matches_dt     ON matches (game_datetime);
CREATE INDEX IF NOT EXISTS idx_matches_queue  ON matches (queue_id);
CREATE INDEX IF NOT EXISTS idx_units_unit     ON participant_units (unit_id);
CREATE INDEX IF NOT EXISTS idx_items_item     ON participant_unit_items (item_id);
CREATE INDEX IF NOT EXISTS idx_traits_trait   ON participant_traits (trait_id, tier_current);
