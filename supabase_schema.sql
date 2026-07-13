-- Interstellar Trail — shared HALL OF THE GRAND TOUR
-- Runs in the SAME Supabase project as Silk Road, but in its OWN table so the two
-- leaderboards never collide (Silk Road ranks by estate; Interstellar Trail by ROI/week).
-- Safe to re-run: it drops and rebuilds only this one table.
-- Paste into the Supabase SQL editor (Dashboard -> SQL Editor -> New query -> Run).

drop table if exists public.inspace_scores cascade;

create table public.inspace_scores (
  id         uuid primary key default gen_random_uuid(),
  run_id     text unique,                 -- one row per voyage; recording upserts it
  score      int,                         -- roi*10 (integer), for ranking (desc)
  data       jsonb,                       -- the whole score object the game stores
  created_at timestamptz default now()
);

alter table public.inspace_scores enable row level security;

-- Open policies for a public hobby leaderboard: anyone may read, add, and update
-- (update lets a recorded voyage upsert cleanly). No delete.
drop policy if exists "inspace_scores_read"   on public.inspace_scores;
drop policy if exists "inspace_scores_insert" on public.inspace_scores;
drop policy if exists "inspace_scores_update" on public.inspace_scores;
create policy "inspace_scores_read"   on public.inspace_scores for select using (true);
create policy "inspace_scores_insert" on public.inspace_scores for insert with check (true);
create policy "inspace_scores_update" on public.inspace_scores for update using (true) with check (true);

create index if not exists inspace_scores_score_idx on public.inspace_scores (score desc);
