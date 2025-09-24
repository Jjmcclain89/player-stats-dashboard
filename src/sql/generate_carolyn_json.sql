WITH player_events AS (
  SELECT 
    p.id as player_id,
    p.first_name,
    p.last_name,
    e.id as event_id,
    e.id as event_code,
    e.name as event_name,
    e.date,
    e.format,
    r.day2,
    r.top8,
    r.limited_wins,
    r.limited_losses,
    r.limited_draws,
    r.constructed_wins,
    r.constructed_losses,
    r.constructed_draws,
    r.day1_wins,
    r.day1_losses,
    r.day1_draws,
    r.day2_wins,
    r.day2_losses,
    r.day2_draws,
    r.day3_wins,
    r.day3_losses,
    r.day3_draws,
    r.in_contention,
    r.win_streak,
    r.loss_streak,
    r.streak5,
    r.finish,
    r.summary,
    r.team,
    r.deck,
    r.notes,
    r.num_drafts,
    r.positive_drafts,
    r.negative_drafts,
    r.trophy_drafts,
    r.no_win_drafts,
    -- Calculate event record (total wins-losses-draws for this specific event)
    (r.day1_wins + r.day2_wins + r.day3_wins) as event_wins,
    (r.day1_losses + r.day2_losses + r.day3_losses) as event_losses,
    (r.day1_draws + r.day2_draws + r.day3_draws) as event_draws,
    ROW_NUMBER() OVER (PARTITION BY p.id ORDER BY e.date) as event_number
  FROM players p
  JOIN results r ON p.id = r.player_id
  JOIN events e ON r.event_id = e.id
),
player_stats AS (
  SELECT 
    player_id,
    first_name,
    last_name,
    COUNT(*) as total_events,
    SUM(CASE WHEN day2 = true THEN 1 ELSE 0 END) as day2s,
    SUM(CASE WHEN in_contention = true THEN 1 ELSE 0 END) as in_contentions,
    SUM(CASE WHEN top8 = true THEN 1 ELSE 0 END) as top8s,
    SUM(day1_wins + day2_wins + day3_wins) as overall_wins,
    SUM(day1_losses + day2_losses + day3_losses) as overall_losses,
    SUM(day1_draws + day2_draws + day3_draws) as overall_draws,
    SUM(limited_wins) as limited_wins,
    SUM(limited_losses) as limited_losses,
    SUM(limited_draws) as limited_draws,
    SUM(constructed_wins) as constructed_wins,
    SUM(constructed_losses) as constructed_losses,
    SUM(constructed_draws) as constructed_draws,
    SUM(day1_wins) as day1_wins,
    SUM(day1_losses) as day1_losses,
    SUM(day1_draws) as day1_draws,
    SUM(day2_wins) as day2_wins,
    SUM(day2_losses) as day2_losses,
    SUM(day2_draws) as day2_draws,
    SUM(day3_wins) as day3_wins,
    SUM(day3_losses) as day3_losses,
    SUM(day3_draws) as day3_draws,
    SUM(num_drafts) as drafts,
    SUM(positive_drafts) as winning_drafts,
    SUM(negative_drafts) as losing_drafts,
    SUM(trophy_drafts) as trophy_drafts,
    SUM(streak5) as streaks_5
  FROM player_events
  GROUP BY player_id, first_name, last_name
)
SELECT json_agg(
  json_build_object(
    'player_info', json_build_object(
      'first_name', ps.first_name,
      'last_name', ps.last_name,
      'full_name', ps.first_name || ' ' || ps.last_name
    ),
    'events', (
      SELECT json_agg(
        json_build_object(
          'event_code', pe.event_name,
          'event_id', pe.event_id,
          'date', pe.date,
          'format', pe.format,
          'deck', pe.deck,
          'notes', pe.notes,
          'finish', pe.finish,
          'record', pe.event_wins || '-' || pe.event_losses || '-' || pe.event_draws
        ) ORDER BY pe.date
      )
      FROM player_events pe
      WHERE pe.player_id = ps.player_id
    ),
    'stats', json_build_object(
      'events', ps.total_events,
      'day2s', ps.day2s,
      'in_contentions', ps.in_contentions,
      'top8s', ps.top8s,
      'overall_wins', ps.overall_wins,
      'overall_losses', ps.overall_losses,
      'overall_draws', ps.overall_draws,
      'overall_record', ps.overall_wins || '-' || ps.overall_losses || '-' || ps.overall_draws,
      'overall_win_pct', ROUND(
        CASE 
          WHEN (ps.overall_wins + ps.overall_losses + ps.overall_draws) = 0 THEN 0 
          ELSE ps.overall_wins::numeric / (ps.overall_wins + ps.overall_losses + ps.overall_draws) * 100 
        END, 2
      ),
      'limited_wins', ps.limited_wins,
      'limited_losses', ps.limited_losses,
      'limited_draws', ps.limited_draws,
      'limited_record', ps.limited_wins || '-' || ps.limited_losses || '-' || ps.limited_draws,
      'limited_win_pct', ROUND(
        CASE 
          WHEN (ps.limited_wins + ps.limited_losses + ps.limited_draws) = 0 THEN 0 
          ELSE ps.limited_wins::numeric / (ps.limited_wins + ps.limited_losses + ps.limited_draws) * 100 
        END, 2
      ),
      'constructed_wins', ps.constructed_wins,
      'constructed_losses', ps.constructed_losses,
      'constructed_draws', ps.constructed_draws,
      'constructed_record', ps.constructed_wins || '-' || ps.constructed_losses || '-' || ps.constructed_draws,
      'constructed_win_pct', ROUND(
        CASE 
          WHEN (ps.constructed_wins + ps.constructed_losses + ps.constructed_draws) = 0 THEN 0 
          ELSE ps.constructed_wins::numeric / (ps.constructed_wins + ps.constructed_losses + ps.constructed_draws) * 100 
        END, 2
      ),
      'day1_wins', ps.day1_wins,
      'day1_losses', ps.day1_losses,
      'day1_draws', ps.day1_draws,
      'day1_win_pct', ROUND(
        CASE 
          WHEN (ps.day1_wins + ps.day1_losses + ps.day1_draws) = 0 THEN 0 
          ELSE ps.day1_wins::numeric / (ps.day1_wins + ps.day1_losses + ps.day1_draws) * 100 
        END, 2
      ),
      'day2_wins', ps.day2_wins,
      'day2_losses', ps.day2_losses,
      'day2_draws', ps.day2_draws,
      'day2_win_pct', ROUND(
        CASE 
          WHEN (ps.day2_wins + ps.day2_losses + ps.day2_draws) = 0 THEN 0 
          ELSE ps.day2_wins::numeric / (ps.day2_wins + ps.day2_losses + ps.day2_draws) * 100 
        END, 2
      ),
      'day3_wins', ps.day3_wins,
      'day3_losses', ps.day3_losses,
      'day3_draws', ps.day3_draws,
      'day3_win_pct', ROUND(
        CASE 
          WHEN (ps.day3_wins + ps.day3_losses + ps.day3_draws) = 0 THEN 0 
          ELSE ps.day3_wins::numeric / (ps.day3_wins + ps.day3_losses + ps.day3_draws) * 100 
        END, 2
      ),
      'top8_record', ps.day3_wins || '-' || ps.day3_losses || '-' || ps.day3_draws,
      'drafts', ps.drafts,
      'winning_drafts', ps.winning_drafts,
      'losing_drafts', ps.losing_drafts,
      'winning_drafts_pct', ROUND(
        CASE 
          WHEN (ps.winning_drafts + ps.losing_drafts) = 0 THEN 0 
          ELSE ps.winning_drafts::numeric / (ps.winning_drafts + ps.losing_drafts) * 100 
        END, 2
      ),
      'trophy_drafts', ps.trophy_drafts,
      '5streaks', ps.streaks_5
    )
  )
) as result
FROM player_stats ps;