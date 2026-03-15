# Phase 1.3 — Set Up Supabase Storage Bucket

**Purpose:** Create a storage bucket for map image uploads. This is done via the Supabase Dashboard or via SQL in the migration.

**Details:**

Add the following to the bottom of the `001_initial_schema.sql` migration file (or execute it separately in the Supabase SQL Editor if the storage API requires it):

1. **Create the bucket:** Insert into `storage.buckets` with `id = 'maps'`, `name = 'maps'`, `public = true`. Public means the image URLs are directly loadable in `<img>` tags without auth headers.

   ```sql
   INSERT INTO storage.buckets (id, name, public)
   VALUES ('maps', 'maps', true);
   ```

2. **Upload policy** -- allow any authenticated user to upload:
   - Policy on `storage.objects` for INSERT
   - `WITH CHECK (bucket_id = 'maps' AND auth.role() = 'authenticated')`
   - Optionally add a check for file size (5MB limit) and MIME type (image/jpeg, image/png, image/webp). Note: Supabase storage policies cannot easily enforce file size/MIME at the SQL level. Instead, enforce these constraints on the client side before uploading, and configure the bucket's allowed MIME types and max file size in the Supabase Dashboard under Storage > Policies.

3. **Read policy** -- allow any authenticated user to read:
   - Policy on `storage.objects` for SELECT
   - `USING (bucket_id = 'maps')`
   - Since the bucket is public, images are readable via public URL anyway. This policy governs API-level listing.

4. **Delete policy** -- only the uploader can delete:
   - Policy on `storage.objects` for DELETE
   - `USING (bucket_id = 'maps' AND auth.uid()::text = (storage.foldername(name))[1])`
   - This assumes the upload path convention `maps/{user_id}/{filename}` so the first folder segment is the user's UUID. Document that the frontend must upload to this path pattern.

After writing the SQL, also add a comment in the migration file reminding the developer to configure the following in the Supabase Dashboard under Storage settings:
- Max file size: 5MB
- Allowed MIME types: `image/jpeg`, `image/png`, `image/webp`
