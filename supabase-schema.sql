-- Maths Reps: run once in Supabase SQL Editor.
-- A signed-in user can read/write only their own backup row.
create table if not exists public.user_backups (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.user_backups enable row level security;

drop policy if exists "Users can read their own Maths Reps backup" on public.user_backups;
create policy "Users can read their own Maths Reps backup"
on public.user_backups for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists "Users can insert their own Maths Reps backup" on public.user_backups;
create policy "Users can insert their own Maths Reps backup"
on public.user_backups for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists "Users can update their own Maths Reps backup" on public.user_backups;
create policy "Users can update their own Maths Reps backup"
on public.user_backups for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

grant select, insert, update on public.user_backups to authenticated;
