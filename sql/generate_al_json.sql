WITH qualified_players AS (
  SELECT DISTINCT
    nq.player_id,
    p.first_name,
    p.last_name
  FROM notable_qualifications nq
  JOIN players p ON nq.player_id = p.id
  WHERE nq.event_id = 13
),
player_events AS (
  SELECT
    qp.player_id,
    qp.first_name,
    qp.last_name,
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
    r.overall_record,
    ROW_NUMBER() OVER (PARTITION BY qp.player_id ORDER BY e.date) as event_number
  FROM qualified_players qp
  LEFT JOIN results r ON qp.player_id = r.player_id
  LEFT JOIN events e ON r.event_id = e.id
),
player_stats AS (
  SELECT
    player_id,
    first_name,
    last_name,
    COUNT(CASE WHEN event_id IS NOT NULL THEN 1 END) as total_events,
    SUM(CASE WHEN day2 = true THEN 1 ELSE 0 END) as day2s,
    SUM(CASE WHEN in_contention = true THEN 1 ELSE 0 END) as in_contentions,
    SUM(CASE WHEN top8 = true THEN 1 ELSE 0 END) as top8s,
    COALESCE(SUM(COALESCE(day1_wins, 0) + COALESCE(day2_wins, 0) + COALESCE(day3_wins, 0)), 0) as overall_wins,
    COALESCE(SUM(COALESCE(day1_losses, 0) + COALESCE(day2_losses, 0) + COALESCE(day3_losses, 0)), 0) as overall_losses,
    COALESCE(SUM(COALESCE(day1_draws, 0) + COALESCE(day2_draws, 0) + COALESCE(day3_draws, 0)), 0) as overall_draws,
    COALESCE(SUM(limited_wins), 0) as limited_wins,
    COALESCE(SUM(limited_losses), 0) as limited_losses,
    COALESCE(SUM(limited_draws), 0) as limited_draws,
    COALESCE(SUM(constructed_wins), 0) as constructed_wins,
    COALESCE(SUM(constructed_losses), 0) as constructed_losses,
    COALESCE(SUM(constructed_draws), 0) as constructed_draws,
    COALESCE(SUM(day1_wins), 0) as day1_wins,
    COALESCE(SUM(day1_losses), 0) as day1_losses,
    COALESCE(SUM(day1_draws), 0) as day1_draws,
    COALESCE(SUM(day2_wins), 0) as day2_wins,
    COALESCE(SUM(day2_losses), 0) as day2_losses,
    COALESCE(SUM(day2_draws), 0) as day2_draws,
    COALESCE(SUM(day3_wins), 0) as day3_wins,
    COALESCE(SUM(day3_losses), 0) as day3_losses,
    COALESCE(SUM(day3_draws), 0) as day3_draws,
    COALESCE(SUM(num_drafts), 0) as drafts,
    COALESCE(SUM(positive_drafts), 0) as winning_drafts,
    COALESCE(SUM(negative_drafts), 0) as losing_drafts,
    COALESCE(SUM(trophy_drafts), 0) as trophy_drafts,
    COALESCE(SUM(streak5), 0) as streaks_5,
    COALESCE(MAX(win_streak), 0) as max_win_streak,
    COALESCE(MAX(loss_streak), 0) as max_loss_streak
  FROM player_events
  GROUP BY player_id, first_name, last_name
),
player_stats_with_calcs AS (
  SELECT
    *,
    ROUND(
      CASE
        WHEN (overall_wins + overall_losses + overall_draws) = 0 THEN 0
        ELSE overall_wins::numeric / (overall_wins + overall_losses + overall_draws) * 100
      END, 1
    ) AS overall_win_pct,
    ROUND(
      CASE
        WHEN (limited_wins + limited_losses + limited_draws) = 0 THEN 0
        ELSE limited_wins::numeric / (limited_wins + limited_losses + limited_draws) * 100
      END, 1
    ) AS limited_win_pct,
    ROUND(
      CASE
        WHEN (constructed_wins + constructed_losses + constructed_draws) = 0 THEN 0
        ELSE constructed_wins::numeric / (constructed_wins + constructed_losses + constructed_draws) * 100
      END, 1
    ) AS constructed_win_pct,
    ROUND(
      CASE
        WHEN (day1_wins + day1_losses + day1_draws) = 0 THEN 0
        ELSE day1_wins::numeric / (day1_wins + day1_losses + day1_draws) * 100
      END, 1
    ) AS day1_win_pct,
    ROUND(
      CASE
        WHEN (day2_wins + day2_losses + day2_draws) = 0 THEN 0
        ELSE day2_wins::numeric / (day2_wins + day2_losses + day2_draws) * 100
      END, 1
    ) AS day2_win_pct,
    ROUND(
      CASE
        WHEN (day3_wins + day3_losses + day3_draws) = 0 THEN 0
        ELSE day3_wins::numeric / (day3_wins + day3_losses + day3_draws) * 100
      END, 1
    ) AS day3_win_pct,
    ROUND(
      CASE
        WHEN (winning_drafts + losing_drafts) = 0 THEN 0
        ELSE winning_drafts::numeric / (winning_drafts + losing_drafts) * 100
      END, 1
    ) AS winning_drafts_pct
  FROM player_stats
),
ranked_players AS (
  SELECT * FROM player_stats_with_calcs WHERE total_events >= 4
),
player_rankings AS (
  SELECT
    player_id,
    RANK() OVER (ORDER BY total_events DESC) AS events_rank,
    RANK() OVER (ORDER BY day2s DESC) AS day2s_rank,
    RANK() OVER (ORDER BY in_contentions DESC) AS in_contentions_rank,
    RANK() OVER (ORDER BY top8s DESC) AS top8s_rank,
    RANK() OVER (ORDER BY overall_wins DESC) AS overall_wins_rank,
    RANK() OVER (ORDER BY overall_losses DESC) AS overall_losses_rank,
    RANK() OVER (ORDER BY overall_draws DESC) AS overall_draws_rank,
    RANK() OVER (ORDER BY overall_win_pct DESC) AS overall_win_pct_rank,
    RANK() OVER (ORDER BY limited_wins DESC) AS limited_wins_rank,
    RANK() OVER (ORDER BY limited_losses DESC) AS limited_losses_rank,
    RANK() OVER (ORDER BY limited_draws DESC) AS limited_draws_rank,
    RANK() OVER (ORDER BY limited_win_pct DESC) AS limited_win_pct_rank,
    RANK() OVER (ORDER BY constructed_wins DESC) AS constructed_wins_rank,
    RANK() OVER (ORDER BY constructed_losses DESC) AS constructed_losses_rank,
    RANK() OVER (ORDER BY constructed_draws DESC) AS constructed_draws_rank,
    RANK() OVER (ORDER BY constructed_win_pct DESC) AS constructed_win_pct_rank,
    RANK() OVER (ORDER BY day1_wins DESC) AS day1_wins_rank,
    RANK() OVER (ORDER BY day1_losses DESC) AS day1_losses_rank,
    RANK() OVER (ORDER BY day1_draws DESC) AS day1_draws_rank,
    RANK() OVER (ORDER BY day1_win_pct DESC) AS day1_win_pct_rank,
    RANK() OVER (ORDER BY day2_wins DESC) AS day2_wins_rank,
    RANK() OVER (ORDER BY day2_losses DESC) AS day2_losses_rank,
    RANK() OVER (ORDER BY day2_draws DESC) AS day2_draws_rank,
    RANK() OVER (ORDER BY day2_win_pct DESC) AS day2_win_pct_rank,
    RANK() OVER (ORDER BY day3_wins DESC) AS day3_wins_rank,
    RANK() OVER (ORDER BY day3_losses DESC) AS day3_losses_rank,
    RANK() OVER (ORDER BY day3_draws DESC) AS day3_draws_rank,
    RANK() OVER (ORDER BY day3_win_pct DESC) AS day3_win_pct_rank,
    RANK() OVER (ORDER BY drafts DESC) AS drafts_rank,
    RANK() OVER (ORDER BY winning_drafts DESC) AS winning_drafts_rank,
    RANK() OVER (ORDER BY losing_drafts DESC) AS losing_drafts_rank,
    RANK() OVER (ORDER BY winning_drafts_pct DESC) AS winning_drafts_pct_rank,
    RANK() OVER (ORDER BY trophy_drafts DESC) AS trophy_drafts_rank,
    RANK() OVER (ORDER BY max_win_streak DESC) AS max_win_streak_rank,
    RANK() OVER (ORDER BY max_loss_streak DESC) AS max_loss_streak_rank,
    RANK() OVER (ORDER BY streaks_5 DESC) AS streaks_5_rank
  FROM ranked_players
)
SELECT json_agg(
  json_build_object(
    'player_info', json_build_object(
      'first_name', ps.first_name,
      'last_name', ps.last_name,
      'full_name', ps.first_name || ' ' || ps.last_name
    ),
    'events', COALESCE((
      SELECT json_agg(
        json_build_object(
          'event_code',  REPLACE(pe.event_name, ' ', ''),
          'event_id', pe.event_id,
          'date', pe.date,
          'format', pe.format,
          'deck', pe.deck,
          'notes', pe.notes,
          'finish', pe.finish,
          'record', pe.overall_record,
          'win_streak', pe.win_streak,
          'loss_streak', pe.loss_streak,
          'trophy_drafts', trophy_drafts
        ) ORDER BY pe.date
      )
      FROM player_events pe
      WHERE pe.player_id = ps.player_id AND pe.event_id IS NOT NULL
    ), '[]'::json),
    'stats', json_build_object(
      'events', json_build_object('value', ps.total_events, 'rank', COALESCE(pr.events_rank, 0)),
      'day2s', json_build_object('value', ps.day2s, 'rank', COALESCE(pr.day2s_rank, 0)),
      'in_contentions', json_build_object('value', ps.in_contentions, 'rank', COALESCE(pr.in_contentions_rank, 0)),
      'top8s', json_build_object('value', ps.top8s, 'rank', COALESCE(pr.top8s_rank, 0)),
      'overall_wins', json_build_object('value', ps.overall_wins, 'rank', COALESCE(pr.overall_wins_rank, 0)),
      'overall_losses', json_build_object('value', ps.overall_losses, 'rank', COALESCE(pr.overall_losses_rank, 0)),
      'overall_draws', json_build_object('value', ps.overall_draws, 'rank', COALESCE(pr.overall_draws_rank, 0)),
      'overall_record', json_build_object('value', ps.overall_wins || '-' || ps.overall_losses || '-' || ps.overall_draws, 'rank', 0),
      'overall_win_pct', json_build_object('value', ps.overall_win_pct, 'rank', COALESCE(pr.overall_win_pct_rank, 0)),
      'limited_wins', json_build_object('value', ps.limited_wins, 'rank', COALESCE(pr.limited_wins_rank, 0)),
      'limited_losses', json_build_object('value', ps.limited_losses, 'rank', COALESCE(pr.limited_losses_rank, 0)),
      'limited_draws', json_build_object('value', ps.limited_draws, 'rank', COALESCE(pr.limited_draws_rank, 0)),
      'limited_record', json_build_object('value', ps.limited_wins || '-' || ps.limited_losses || '-' || ps.limited_draws, 'rank', 0),
      'limited_win_pct', json_build_object('value', ps.limited_win_pct, 'rank', COALESCE(pr.limited_win_pct_rank, 0)),
      'constructed_wins', json_build_object('value', ps.constructed_wins, 'rank', COALESCE(pr.constructed_wins_rank, 0)),
      'constructed_losses', json_build_object('value', ps.constructed_losses, 'rank', COALESCE(pr.constructed_losses_rank, 0)),
      'constructed_draws', json_build_object('value', ps.constructed_draws, 'rank', COALESCE(pr.constructed_draws_rank, 0)),
      'constructed_record', json_build_object('value', ps.constructed_wins || '-' || ps.constructed_losses || '-' || ps.constructed_draws, 'rank', 0),
      'constructed_win_pct', json_build_object('value', ps.constructed_win_pct, 'rank', COALESCE(pr.constructed_win_pct_rank, 0)),
      'day1_wins', json_build_object('value', ps.day1_wins, 'rank', COALESCE(pr.day1_wins_rank, 0)),
      'day1_losses', json_build_object('value', ps.day1_losses, 'rank', COALESCE(pr.day1_losses_rank, 0)),
      'day1_draws', json_build_object('value', ps.day1_draws, 'rank', COALESCE(pr.day1_draws_rank, 0)),
      'day1_record', json_build_object('value', ps.day1_wins || '-' || ps.day1_losses || '-' || ps.day1_draws, 'rank', 0),
      'day1_win_pct', json_build_object('value', ps.day1_win_pct, 'rank', COALESCE(pr.day1_win_pct_rank, 0)),
      'day2_wins', json_build_object('value', ps.day2_wins, 'rank', COALESCE(pr.day2_wins_rank, 0)),
      'day2_losses', json_build_object('value', ps.day2_losses, 'rank', COALESCE(pr.day2_losses_rank, 0)),
      'day2_draws', json_build_object('value', ps.day2_draws, 'rank', COALESCE(pr.day2_draws_rank, 0)),
      'day2_record', json_build_object('value', ps.day2_wins || '-' || ps.day2_losses || '-' || ps.day2_draws, 'rank', 0),
      'day2_win_pct', json_build_object('value', ps.day2_win_pct, 'rank', COALESCE(pr.day2_win_pct_rank, 0)),
      'day3_wins', json_build_object('value', ps.day3_wins, 'rank', COALESCE(pr.day3_wins_rank, 0)),
      'day3_losses', json_build_object('value', ps.day3_losses, 'rank', COALESCE(pr.day3_losses_rank, 0)),
      'day3_draws', json_build_object('value', ps.day3_draws, 'rank', COALESCE(pr.day3_draws_rank, 0)),
      'day3_record', json_build_object('value', ps.day3_wins || '-' || ps.day3_losses || '-' || ps.day3_draws, 'rank', 0),
      'day3_win_pct', json_build_object('value', ps.day3_win_pct, 'rank', COALESCE(pr.day3_win_pct_rank, 0)),
      'top8_record', json_build_object('value', ps.day3_wins || '-' || ps.day3_losses || '-' || ps.day3_draws, 'rank', 0),
      'drafts', json_build_object('value', ps.drafts, 'rank', COALESCE(pr.drafts_rank, 0)),
      'winning_drafts', json_build_object('value', ps.winning_drafts, 'rank', COALESCE(pr.winning_drafts_rank, 0)),
      'losing_drafts', json_build_object('value', ps.losing_drafts, 'rank', COALESCE(pr.losing_drafts_rank, 0)),
      'drafts_record', json_build_object('value', ps.winning_drafts || '-' || ps.losing_drafts, 'rank', 0),
      'winning_drafts_pct', json_build_object('value', ps.winning_drafts_pct, 'rank', COALESCE(pr.winning_drafts_pct_rank, 0)),
      'trophy_drafts', json_build_object('value', ps.trophy_drafts, 'rank', COALESCE(pr.trophy_drafts_rank, 0)),
      'max_win_streak', json_build_object('value', ps.max_win_streak, 'rank', COALESCE(pr.max_win_streak_rank, 0)),
      'max_loss_streak', json_build_object('value', ps.max_loss_streak, 'rank', COALESCE(pr.max_loss_streak_rank, 0)),
      '5streaks', json_build_object('value', ps.streaks_5, 'rank', COALESCE(pr.streaks_5_rank, 0))
    )
  )
) as result
FROM player_stats_with_calcs ps
LEFT JOIN player_rankings pr ON ps.player_id = pr.player_id;
