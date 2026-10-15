# Match JSON notes (Set 18, observed Oct 2026)

- Routing: ladder via na1, matches via americas
- info: game_datetime (ms epoch), game_length (s), queue_id, tft_set_number, tft_set_core_name, tft_game_type
- game_version is a placeholder ("TFT Unreal Version ?.?.?.?"): derive patch from game_datetime
- NO augments field in this set
- participant: puuid, placement, level, gold_left, last_round, players_eliminated,
  total_damage_to_players, time_eliminated, win, traits[], units[]
- unit: character_id (DA_18_*), tier (stars), rarity, itemNames[] (0-3, DA_* ids)
- trait: name, num_units, style, tier_current (0 = inactive), tier_total
- PRIVACY: riotIdGameName / riotIdTagline must never be stored or committed
