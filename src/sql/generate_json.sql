WITH player_events AS (
  SELECT 
    p.id as player_id,
    p.first_name,
    p.last_name,
    e.id as event_id,
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
),
ranked AS (
  SELECT 
    player_id,
    first_name || ' ' || last_name AS player_full_name,
    total_events AS events,
    day2s,
    in_contentions,
    top8s,
    overall_wins,
    overall_losses,
    overall_draws,
    ROUND(
      CASE 
        WHEN (overall_wins + overall_losses + overall_draws) = 0 THEN 0
        ELSE overall_wins::numeric / (overall_wins + overall_losses + overall_draws) * 100
      END, 2
    ) AS overall_win_pct,
    limited_wins,
    limited_losses,
    limited_draws,
    ROUND(
      CASE 
        WHEN (limited_wins + limited_losses + limited_draws) = 0 THEN 0
        ELSE limited_wins::numeric / (limited_wins + limited_losses + limited_draws) * 100
      END, 2
    ) AS limited_win_pct,
    constructed_wins,
    constructed_losses,
    constructed_draws,
    ROUND(
      CASE 
        WHEN (constructed_wins + constructed_losses + constructed_draws) = 0 THEN 0
        ELSE constructed_wins::numeric / (constructed_wins + constructed_losses + constructed_draws) * 100
      END, 2
    ) AS constructed_win_pct,
    day1_wins,
    day1_losses,
    day1_draws,
    ROUND(
      CASE 
        WHEN (day1_wins + day1_losses + day1_draws) = 0 THEN 0
        ELSE day1_wins::numeric / (day1_wins + day1_losses + day1_draws) * 100
      END, 2
    ) AS day1_win_pct,
    day2_wins,
    day2_losses,
    day2_draws,
    ROUND(
      CASE 
        WHEN (day2_wins + day2_losses + day2_draws) = 0 THEN 0
        ELSE day2_wins::numeric / (day2_wins + day2_losses + day2_draws) * 100
      END, 2
    ) AS day2_win_pct,
    day3_wins,
    day3_losses,
    day3_draws,
    ROUND(
      CASE 
        WHEN (day3_wins + day3_losses + day3_draws) = 0 THEN 0
        ELSE day3_wins::numeric / (day3_wins + day3_losses + day3_draws) * 100
      END, 2
    ) AS day3_win_pct,
    drafts,
    winning_drafts,
    losing_drafts,
    ROUND(
      CASE 
        WHEN (winning_drafts + losing_drafts) = 0 THEN 0
        ELSE winning_drafts::numeric / (winning_drafts + losing_drafts) * 100
      END, 2
    ) AS winning_drafts_pct,
    trophy_drafts,
    streaks_5
  FROM player_stats
),

-- top 10 CTEs (one per stat)
top10_events AS (
  SELECT rank, player_full_name, events AS stat_value
  FROM (SELECT player_full_name, events, ROW_NUMBER() OVER (ORDER BY events DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_day2s AS (
  SELECT rank, player_full_name, day2s AS stat_value
  FROM (SELECT player_full_name, day2s, ROW_NUMBER() OVER (ORDER BY day2s DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_in_contentions AS (
  SELECT rank, player_full_name, in_contentions AS stat_value
  FROM (SELECT player_full_name, in_contentions, ROW_NUMBER() OVER (ORDER BY in_contentions DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_top8s AS (
  SELECT rank, player_full_name, top8s AS stat_value
  FROM (SELECT player_full_name, top8s, ROW_NUMBER() OVER (ORDER BY top8s DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_overall_wins AS (
  SELECT rank, player_full_name, overall_wins AS stat_value
  FROM (SELECT player_full_name, overall_wins, ROW_NUMBER() OVER (ORDER BY overall_wins DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_overall_losses AS (
  SELECT rank, player_full_name, overall_losses AS stat_value
  FROM (SELECT player_full_name, overall_losses, ROW_NUMBER() OVER (ORDER BY overall_losses DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_overall_draws AS (
  SELECT rank, player_full_name, overall_draws AS stat_value
  FROM (SELECT player_full_name, overall_draws, ROW_NUMBER() OVER (ORDER BY overall_draws DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_overall_win_pct AS (
  SELECT rank, player_full_name, overall_win_pct AS stat_value
  FROM (SELECT player_full_name, overall_win_pct, ROW_NUMBER() OVER (ORDER BY overall_win_pct DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_limited_wins AS (
  SELECT rank, player_full_name, limited_wins AS stat_value
  FROM (SELECT player_full_name, limited_wins, ROW_NUMBER() OVER (ORDER BY limited_wins DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_limited_losses AS (
  SELECT rank, player_full_name, limited_losses AS stat_value
  FROM (SELECT player_full_name, limited_losses, ROW_NUMBER() OVER (ORDER BY limited_losses DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_limited_draws AS (
  SELECT rank, player_full_name, limited_draws AS stat_value
  FROM (SELECT player_full_name, limited_draws, ROW_NUMBER() OVER (ORDER BY limited_draws DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_limited_win_pct AS (
  SELECT rank, player_full_name, limited_win_pct AS stat_value
  FROM (SELECT player_full_name, limited_win_pct, ROW_NUMBER() OVER (ORDER BY limited_win_pct DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_constructed_wins AS (
  SELECT rank, player_full_name, constructed_wins AS stat_value
  FROM (SELECT player_full_name, constructed_wins, ROW_NUMBER() OVER (ORDER BY constructed_wins DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_constructed_losses AS (
  SELECT rank, player_full_name, constructed_losses AS stat_value
  FROM (SELECT player_full_name, constructed_losses, ROW_NUMBER() OVER (ORDER BY constructed_losses DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_constructed_draws AS (
  SELECT rank, player_full_name, constructed_draws AS stat_value
  FROM (SELECT player_full_name, constructed_draws, ROW_NUMBER() OVER (ORDER BY constructed_draws DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_constructed_win_pct AS (
  SELECT rank, player_full_name, constructed_win_pct AS stat_value
  FROM (SELECT player_full_name, constructed_win_pct, ROW_NUMBER() OVER (ORDER BY constructed_win_pct DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_day1_wins AS (
  SELECT rank, player_full_name, day1_wins AS stat_value
  FROM (SELECT player_full_name, day1_wins, ROW_NUMBER() OVER (ORDER BY day1_wins DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_day1_losses AS (
  SELECT rank, player_full_name, day1_losses AS stat_value
  FROM (SELECT player_full_name, day1_losses, ROW_NUMBER() OVER (ORDER BY day1_losses DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_day1_draws AS (
  SELECT rank, player_full_name, day1_draws AS stat_value
  FROM (SELECT player_full_name, day1_draws, ROW_NUMBER() OVER (ORDER BY day1_draws DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_day1_win_pct AS (
  SELECT rank, player_full_name, day1_win_pct AS stat_value
  FROM (SELECT player_full_name, day1_win_pct, ROW_NUMBER() OVER (ORDER BY day1_win_pct DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_day2_wins AS (
  SELECT rank, player_full_name, day2_wins AS stat_value
  FROM (SELECT player_full_name, day2_wins, ROW_NUMBER() OVER (ORDER BY day2_wins DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_day2_losses AS (
  SELECT rank, player_full_name, day2_losses AS stat_value
  FROM (SELECT player_full_name, day2_losses, ROW_NUMBER() OVER (ORDER BY day2_losses DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_day2_draws AS (
  SELECT rank, player_full_name, day2_draws AS stat_value
  FROM (SELECT player_full_name, day2_draws, ROW_NUMBER() OVER (ORDER BY day2_draws DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_day2_win_pct AS (
  SELECT rank, player_full_name, day2_win_pct AS stat_value
  FROM (SELECT player_full_name, day2_win_pct, ROW_NUMBER() OVER (ORDER BY day2_win_pct DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_day3_wins AS (
  SELECT rank, player_full_name, day3_wins AS stat_value
  FROM (SELECT player_full_name, day3_wins, ROW_NUMBER() OVER (ORDER BY day3_wins DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_day3_losses AS (
  SELECT rank, player_full_name, day3_losses AS stat_value
  FROM (SELECT player_full_name, day3_losses, ROW_NUMBER() OVER (ORDER BY day3_losses DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_day3_draws AS (
  SELECT rank, player_full_name, day3_draws AS stat_value
  FROM (SELECT player_full_name, day3_draws, ROW_NUMBER() OVER (ORDER BY day3_draws DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_day3_win_pct AS (
  SELECT rank, player_full_name, day3_win_pct AS stat_value
  FROM (SELECT player_full_name, day3_win_pct, ROW_NUMBER() OVER (ORDER BY day3_win_pct DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_drafts AS (
  SELECT rank, player_full_name, drafts AS stat_value
  FROM (SELECT player_full_name, drafts, ROW_NUMBER() OVER (ORDER BY drafts DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_winning_drafts AS (
  SELECT rank, player_full_name, winning_drafts AS stat_value
  FROM (SELECT player_full_name, winning_drafts, ROW_NUMBER() OVER (ORDER BY winning_drafts DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_losing_drafts AS (
  SELECT rank, player_full_name, losing_drafts AS stat_value
  FROM (SELECT player_full_name, losing_drafts, ROW_NUMBER() OVER (ORDER BY losing_drafts DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_winning_drafts_pct AS (
  SELECT rank, player_full_name, winning_drafts_pct AS stat_value
  FROM (SELECT player_full_name, winning_drafts_pct, ROW_NUMBER() OVER (ORDER BY winning_drafts_pct DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_trophy_drafts AS (
  SELECT rank, player_full_name, trophy_drafts AS stat_value
  FROM (SELECT player_full_name, trophy_drafts, ROW_NUMBER() OVER (ORDER BY trophy_drafts DESC) as rank FROM ranked) t
  WHERE rank <= 10
),
top10_5streaks AS (
  SELECT rank, player_full_name, streaks_5 AS stat_value
  FROM (SELECT player_full_name, streaks_5, ROW_NUMBER() OVER (ORDER BY streaks_5 DESC) as rank FROM ranked) t
  WHERE rank <= 10
)

SELECT json_build_object(
  'players', (
    SELECT json_object_agg(
      'entry_' || ps.player_id,
      json_build_object(
        'player', json_build_object(
          'first_name', ps.first_name,
          'last_name', ps.last_name,
          'full_name', ps.first_name || ' ' || ps.last_name
        ),
        'events', (
          SELECT json_object_agg(
            'entry_' || pe.event_number,
            json_build_object(
              'event_code', pe.event_name,
              'event_id', pe.event_id,
              'date', pe.date,
              'format', pe.format,
              'deck', pe.deck,
              'notes', pe.notes,
              'finish', pe.finish
            )
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
          'longest_win_streak', null,
          '5streaks', ps.streaks_5,
          'longest_loss_streak', null
        )
      )
    )
    FROM player_stats ps
  ),
  'top_10', json_build_object(
    'events', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_events),
    'day2s', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_day2s),
    'in_contentions', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_in_contentions),
    'top8s', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_top8s),
    'overall_wins', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_overall_wins),
    'overall_losses', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_overall_losses),
    'overall_draws', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_overall_draws),
    'overall_win_pct', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_overall_win_pct),
    'limited_wins', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_limited_wins),
    'limited_losses', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_limited_losses),
    'limited_draws', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_limited_draws),
    'limited_win_pct', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_limited_win_pct),
    'constructed_wins', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_constructed_wins),
    'constructed_losses', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_constructed_losses),
    'constructed_draws', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_constructed_draws),
    'constructed_win_pct', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_constructed_win_pct),
    'day1_wins', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_day1_wins),
    'day1_losses', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_day1_losses),
    'day1_draws', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_day1_draws),
    'day1_win_pct', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_day1_win_pct),
    'day2_wins', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_day2_wins),
    'day2_losses', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_day2_losses),
    'day2_draws', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_day2_draws),
    'day2_win_pct', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_day2_win_pct),
    'day3_wins', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_day3_wins),
    'day3_losses', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_day3_losses),
    'day3_draws', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_day3_draws),
    'day3_win_pct', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_day3_win_pct),
    'drafts', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_drafts),
    'winning_drafts', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_winning_drafts),
    'losing_drafts', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_losing_drafts),
    'winning_drafts_pct', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_winning_drafts_pct),
    'trophy_drafts', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_trophy_drafts),
    '5streaks', (SELECT json_object_agg(rank::text, json_build_object('rank', rank, 'player_full_name', player_full_name, 'stat_value', stat_value)) FROM top10_5streaks)
  )
) AS result;
